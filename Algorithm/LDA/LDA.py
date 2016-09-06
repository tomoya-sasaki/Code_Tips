
# coding: utf-8

# # Table of Contents
#  <p>

# Reference: http://satomacoto.blogspot.jp/2009/12/pythonlda.html   
# Code in the reference is modified for Python 3  
# 
# LDA ([Blei et al.](http://www.jmlr.org/papers/volume3/blei03a/blei03a.pdf) Figure 1)  
# Variational Bayes EM

# In[2]:

import sys,getopt
from numpy import array,matrix,diag
from scipy import sum,log,exp,mean,dot,ones,zeros
from scipy.special import polygamma
from scipy.linalg import norm
from random import random
import os


# In[3]:

os.chdir("/home/3928941380/Downloads/")


# In[19]:

def main():
    # set parameters
    k = 10 # of classes to assume
    emmax = 100 # of maximum VB-EM iteration (default 100)
    demmax = 20 # of maximum VB-EM iteration for a document
    epsilon = 0.0001 # A threshold to determine the whole convergence of the estimation
    
    # Train
    train = open("train.txt",'r').read()
    alpha,beta = ldamain(train, k, emmax, demmax, epsilon)
    
    # Write
    writer = open('output-alpha.txt','w')
    writer.write(str(alpha.tolist()))
    writer.close() 
    
    writer = open('output-beta.txt','w')
    writer.write(str(beta.tolist()))
    writer.close()


# In[51]:

def ldamain(train, k, emmax=100, demmax=20, epsilon=1.0e-4):
    d = [ zip(*[ [int(x) for x in w.split(':')] for w in L.split()]) for L in train.split('\n') if L ]
    
    data = []
    for L in train.split("\n"):
        if L == "":
            continue

        id_ = [int(w.split(":")[0]) for w in L.split(" ")]
        w_count = [int(w.split(":")[1]) for w in L.split(" ")]

        data.append([id_, w_count])
    
    return lda.train(data,k,emmax,demmax)


# Originalではtupleになっていたものを、listで書いた:
# 
# ```
# >>> d[0]
# [(10, 37, 40, 43, 62, 72, 75, 102, 111, 115, 131, 164, 208, 281, 315, 321, 331, 355, 368, 377, 379, 392, 416, 419, 434, 435, 477, 487, 499, 501, 586, 594, 598, 618, 621, 637, 677, 692, 702, 799, 808, 809, 828, 896, 901, 908, 941, 988, 1035, 1065, 1083, 1085, 1112, 1124, 1141, 1170, 1171, 1175, 1178, 1188, 1197, 1198, 1219, 1270, 1285, 1292, 1293, 1308, 1311), (7, 1, 1, 1, 3, 1, 1, 1, 2, 1, 1, 1, 1, 1, 3, 1, 3, 1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 2, 1, 1, 4, 1, 2, 1, 1, 1, 4, 1, 2, 10, 1, 1, 2, 1, 1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 1, 12, 1, 1, 2, 5, 1, 1, 1, 4, 1, 1, 3, 2)]
# 
# >>> d[0][0]
# (10, 37, 40, 43, 62, 72, 75, 102, 111, 115, 131, 164, 208, 281, 315, 321, 331, 355, 368, 377, 379, 392, 416, 419, 434, 435, 477, 487, 499, 501, 586, 594, 598, 618, 621, 637, 677, 692, 702, 799, 808, 809, 828, 896, 901, 908, 941, 988, 1035, 1065, 1083, 1085, 1112, 1124, 1141, 1170, 1171, 1175, 1178, 1188, 1197, 1198, 1219, 1270, 1285, 1292, 1293, 1308, 1311)
# 
# >>> train.split("\n")[0]
# '10:7 37:1 40:1 43:1 62:3 72:1 75:1 102:1 111:2 115:1 131:1 164:1 208:1 281:1 315:3 321:1 331:3 355:1 368:2 377:1 379:1 392:1 416:2 419:1 434:1 435:2 477:1 487:2 499:1 501:1 586:4 594:1 598:2 618:1 621:1 637:1 677:4 692:1 702:2 799:10 808:1 809:1 828:2 896:1 901:1 908:1 941:1 988:1 1035:1 1065:5 1083:1 1085:1 1112:1 1124:1 1141:1 1170:1 1171:12 1175:1 1178:1 1188:2 1197:5 1198:1 1219:1 1270:1 1285:4 1292:1 1293:1 1308:3 1311:2'
# ```

# In[55]:

class lda():
    '''
    Latent Dirichlet Allocation, standard model.
    [alpha,beta] = lda.train(d,k,[emmax,demmax])
    d      : data of documents
    k      : # of classes to assume
    emmax  : # of maximum VB-EM iteration (default 100)
    demmax : # of maximum VB-EM iteration for a document (default 20)
    '''
    
    @staticmethod
    def train(d, k, emmax=100, demmax=20, epsilon=1.0e-4):
        '''
        Latent Dirichlet Allocation, standard model.
        [alpha,beta] = lda.train(d,k,[emmax,demmax])
        d      : data of documents
        k      : # of classes to assume
        emmax  : # of maximum VB-EM iteration (default 100)
        demmax : # of maximum VB-EM iteration for a document (default 20)
        '''
        
        # # of documents
        n = len(d)
        # # of words
        L = max(map(lambda x: max(x[0]), d)) + 1
        
        # initialize
        beta = ones((L, k)) / L
        alpha = lda.normalize(sorted([random() for i in range(k)], reverse=True))
        gammas = zeros((n, k))
        lik = 0
        plik = lik
        
        print ('number of documents (n)      = {0}'.format(n))
        print ('number of words (l)          = {0}'.format(L))
        print ('number of latent classes (k) = {0}'.format(k))
        
        for j in range(emmax):
            print ('iteration {0}/{1}..\t'.format(j+1, emmax))
            #vb-esstep
            betas = zeros((L, k))
            for i in range(n):
                gamma,q = lda.vbem(d[i], beta, alpha, demmax)
                gammas[i,:] = gamma
                betas = lda.accum_beta(betas,q,d[i])
            #vb-mstep
            alpha = lda.newton_alpha(gammas)
            beta = lda.mnormalize(betas,0)
            #converge?
            lik = lda.lda_lik(d, beta, gammas)
            print ('log-likelihoood =', lik)
            if j > 1 and abs((lik - plik) / lik) < epsilon:
                if j < 5:
                    print
                    return lda.train(d, k, emmax, demmax) # try again
                    return
                print ('converged')
                return alpha, beta
            plik = lik
                

    @staticmethod
    def vbem(d, beta, alpha0, emmax=20):
        '''
        [alpha,q] = vbem(d,beta,alpha0,[emmax])
        calculates a document and words posterior for a document d.
        alpha  : Dirichlet posterior for a document d
        q      : (L * K) matrix of word posterior over latent classes
        d      : document data
        beta   : 
        alpha0 : Dirichlet prior of alpha
        emmax  : maximum # of VB-EM iteration.
        '''
        digamma = lambda x: polygamma(0,x)

        L = len(d[0])
        k = len(alpha0)
        q = zeros((L, k))
        nt = ones((1, k)) * L / k
        pnt = nt
        
        for j in range(emmax):
            #vb-estep
            q = lda.mnormalize(matrix(beta[d[0],:]) * matrix(diag(exp(digamma(alpha0 + nt))[0])), 1)
            #vb-mstep
            nt = matrix(d[1]) * q
            #converge?
            if j > 1 and lda.converged(nt, pnt, 1.0e-2):
                break
            pnt = nt.copy()
        alpha = alpha0 + nt
        return alpha, q

    @staticmethod
    def accum_beta(betas, q, t):
        '''
        betas = accum_beta(betas,q,t)
        accumulates word posteriors to latent classes.
        betas : (V * K) matrix of summand
        q     : (L * K) matrix of word posteriors
        t     : document of struct array
        '''
        betas[t[0],:] += matrix(diag(t[1])) * q        
        return betas
    
    @staticmethod
    def lda_lik(d, beta, gammas):
        '''
        lik = lda_lik(d, beta, gammas)
        returns the likelihood of d, given LDA model of (beta, gammas).
        '''
        egamma = matrix(lda.mnormalize(gammas, 1))
        lik = 0
        n = len(d)
        for i in range(n):
            t = d[i]
            lik += (matrix(t[1]) * log(matrix(beta[t[0],:]) * egamma[i,:].T))[0,0]
        return lik

    @staticmethod
    def newton_alpha(gammas,maxiter=20,ini_alpha=[]):
        '''
        alpha = newton_alpha (gammas,[maxiter])
        Newton-Raphson iteration of LDA Dirichlet prior.
        gammas  : matrix of Dirichlet posteriors (M * k)
        maxiter : # of maximum iteration of Newton-Raphson
        '''
        digamma = lambda x: polygamma(0, x)
        trigamma = lambda x: polygamma(1, x)

        M,K = gammas.shape
        
        if not M > 1:
            return gammas[1,:]
        if not len(ini_alpha) > 0:
            ini_alpha = mean(gammas, 0) / K
        
        L = 0
        g = zeros((1,K))
        pg = sum(digamma(gammas), 0) - sum(digamma(sum(gammas, 1)))
        alpha = ini_alpha.copy()
        palpha = zeros((1, K))
        
        for t in range(maxiter):
            L += 1
            alpha0 = sum(alpha)
            g = M * (digamma(alpha0) - digamma(alpha)) + pg
            h = -1.0 / trigamma(alpha)
            hgz = dot(h,g) / (1.0 / trigamma(alpha0) + sum(h))

            for i in range(K):
                alpha[i] = alpha[i] - h[i] * (g[i] - hgz) / M
                if alpha[i] < 0:
                    return lda.newton_alpha(gammas, maxiter, ini_alpha / 10.0)
            
            #converge?
            if L > 1 and lda.converged(alpha, palpha, 1.0e-4):
                break
            
            palpha = alpha.copy()
        
        return alpha
    
    @staticmethod
    def normalize(v):
        return v / sum(v)
    
    @staticmethod
    def mnormalize(m, d=0):
        '''
        x = mnormalize(m, d)
        normalizes a 2-D matrix m along the dimension d.
        m : matrix
        d : dimension to normalize (default 0)
        '''
        m = array(m)
        v = sum(m, d)
        if d == 0:
            return m * matrix(diag(1.0 / v))
        else:
            return matrix(diag(1.0 / v)) * m
        
    @staticmethod
    def converged(u, udash, threshold=1.0e-3):
        '''
        converged(u,udash,threshold)
        Returns 1 if u and udash are not different by the ratio threshold
        '''
        return norm(u - udash) / norm(u) < threshold


# In[ ]:

if __name__ == '__main__':
    main()

