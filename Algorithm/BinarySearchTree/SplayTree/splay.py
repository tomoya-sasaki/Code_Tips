# Top-Down Splay (Alternative for Python dictionary)
# However, Python dictionary seems to be faster because it uses Hash Table.
# Hash Table: unordered_map (C++, not std::map)
# Reference: http://www.geocities.jp/m_hiroi/light/pyalgo21.html

# Adjust recursive time
import sys
sys.setrecursionlimit(10000)

class Node:
    def __init__(self, key=None, value=None):
        self.key = key
        self.value = value

        self.left = None
        self.right = None

class TDSplay:
    def __init__(self):
        self.root_node = None

    def make_root(self, key, value=None):
        self.root_node = Node(key, value)

    def search(self, key):
        if self.root_node is None:
            self.make_root(key)

        node = self.splay(self.root_node, key)

        if node.key == key:
            # Node exits, just edit the value
            # Node at the top right now is what we want
            self.root_node = node
            return node
        else:
            # create a new node
            new_node = Node(key, None)

            if key < node.key:
                new_node.right = node
                new_node.left = node.left
                node.left = None
            else:
                new_node.left = node
                new_node.right = node.right
                node.right = None

            self.root_node = new_node
            return new_node


    def delete(self, key):
        if self.root_node is None:
            return None

        node = self.splay(self.root_node, key)

        if node.key != key:
            return None

        else:
            if node.left is None:
                self.root_node = node.right
            elif node.right is None:
                self.root_node = node.left
            else:
                node1 = self.splay(node.left, key)
                node1.right = node.right
                self.root_node = node1

    def rotate_right(self, node):
        lnode = node.left
        node.left = lnode.right
        lnode.right = node
        return lnode

    def rotate_left(self, node):
        rnode = node.right
        node.right = rnode.left
        rnode.left = node
        return rnode

    def splay(self, node, check_key):
        wnode = Node()
        rnode = wnode
        lnode = wnode
    
        while True:
            if node.key == check_key:
                break
    
            elif check_key < node.key:
                if node.left is None:
                    break
                if check_key < node.left.key:
                    node = self.rotate_right(node)
                    if node.left is None:
                        break
                rnode.left = node
                rnode = node
                node = node.left
            else:
                if node.right is None:
                    break
                if node.right.key < check_key:
                    node = self.rotate_left(node)
                    if node.right is None:
                        break
                lnode.right = node
                lnode = node
                node = node.right
    
        rnode.left = node.right
        lnode.right = node.left
        node.left = wnode.right
        node.right = wnode.left
        return node

    # # Recursive version is slow
    # def finish(self, node):
    #     self.rnode.left = node.right
    #     self.lnode.right = node.left
    #     node.left = self.wnode.right
    #     node.right = self.wnode.left
    #     return node
    #
    # def splay(self, node, check_key):
    #     def splay_(self, node):
    #         if node.key == check_key:
    #             return self.finish(node) 
    #
    #         elif check_key < node.key:
    #             if node.left is None:
    #                 return self.finish(node)
    #
    #             if check_key < node.left.key:
    #                 node = self.rotate_right(node)
    #
    #                 if node.left is None:
    #                     return self.finish(node)
    #
    #             self.rnode.left = node
    #             self.rnode = node
    #             node = node.left
    #
    #         else:
    #             if node.right is None:
    #                 return self.finish(node)
    #
    #             if node.right.key < check_key:
    #                 node = self.rotate_left(node)
    #
    #                 if node.right is None:
    #                     return self.finish(node)
    #
    #             self.lnode.right = node
    #             self.lnode = node
    #             node = node.right
    #
    #         return splay_(self, node)
    #
    #     self.wnode = Node()
    #     self.rnode = self.wnode
    #     self.lnode = self.wnode
    #     return splay_(self, node)

    def show(self):
        def show_(node):
            key_node = str(node.key)
            if node.left is not None:
                key_left = str(node.left.key)
            else:
                key_left = "-"

            if node.right is not None:
                key_right = str(node.right.key)
            else:
                key_right = "-"


            a = key_node + " / L:" + key_left + " / R:" + key_right

            if node.left is not None:
                show_(node.left)
            if node.right is not None:
                show_(node.right)

            print(a)

            return 

        if self.root_node is None:
            self.make_root(None)
        show_(self.root_node)


if __name__ == '__main__':
    tree = TDSplay()
    import numpy as np

    a = np.array([i for i in range(5)])
    np.random.shuffle(a)
    
    for i in a:
        print(i)
        tree.search(i)

    print("Show:")
    tree.show()
