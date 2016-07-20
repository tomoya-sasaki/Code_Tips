# Julia

## Tutorials
[Econometrics with Julia](http://quant-econ.net/jl/getting_started.html)

\begin{align}
&\|\mathbf{x} - \mathbf{\alpha} \|^2 - \|\mathbf{x} - \mathbf{\beta}\|^2\\
&= \|\mathbf{x}\| \|\mathbf{x}\| - 2 \|\mathbf{\mathbf{\alpha}}\| \|\mathbf{x}\| + \|\mathbf{\alpha}\| \|\mathbf{\mathbf{\alpha}}\|  - \|\mathbf{x}\| \|\mathbf{x}\| +2 \|\mathbf{\beta}\| \|\mathbf{x}\| - \|\mathbf{\beta}\| \|\mathbf{\beta}\|\\
&= \mathbf{\alpha}^T \mathbf{\alpha} - \beta^T \beta + 2(\sqrt{\mathbf{\beta}\cdot\mathbf{\beta}}-\sqrt{\mathbf{\alpha}\cdot\mathbf{\alpha}})\|\mathbf{x}\|\\
&= \mathbf{\alpha}^T \mathbf{\alpha} - \beta^T \beta + 2(\sqrt{\mathbf{\beta}\cdot\mathbf{\beta}}-\sqrt{\mathbf{\alpha}\cdot\mathbf{\alpha}})(\sqrt{\mathbf{x}\cdot\mathbf{x}}),
\end{align}

$$\mathbf{\alpha}^T \mathbf{\alpha} - \beta^T \beta + 2(\sqrt{\mathbf{\beta}\cdot\mathbf{\beta}}-\sqrt{\mathbf{\alpha}\cdot\mathbf{\alpha}})(\sqrt{\mathbf{x}\cdot\mathbf{x}})$$

$x$
