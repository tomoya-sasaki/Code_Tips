# Adaptive Parallel Temperling
using LinearAlgebra
using Distributions
using Random
using Gadfly
using StatsFuns
using Statistics
using Cairo
using Colors
using DataFrames

#
# Preparation
#

# Set parameters
Random.seed!(120);  #  random number generator
K_true = 3;  # the number of categories (peaks)
D = 1;  # the dimension of the data
N = 1000;  # the number of the data
alpha = repeat([1.0], K_true);
mu_true = [-1, 2.0, 4.5]  # 1 x K Array
tSigma = [0.5, 0.2, 0.3];

theta_true = rand(Dirichlet(alpha));
Z_count = rand(Multinomial(N, theta_true));

# Weight of each Category
Z_prob = [0.3, 0.4, 0.3]

# Randomly generate data points
val_max = 7;
val_min = -7;
x = val_min:0.1:val_max;
Da = [DataFrame(x=x, ymax=pdf.(Normal(mu_true[index], tSigma[index]),x),
                ymin=0.0, u = "$index") for index in 1:K_true];

p1 = plot(vcat(Da...), x=:x, y=:ymax, ymin=:ymin, ymax=:ymax, color=:u,
    Geom.line, Geom.ribbon, Guide.ylabel("Density"),
    Theme(lowlight_color=c->RGBA{Float32}(c.r, c.g, c.b, 0.4)),
    Coord.cartesian(xmin=val_min, xmax=val_max),
    Guide.colorkey(title="", pos=[2.5,0.6]), Guide.title("PDF")
);
draw(PDF("1Dtruth.pdf", 4inch, 4inch), p1)

#
# Sampling
#
  #
  # Check: https://www.tweag.io/blog/2020-10-28-mcmc-intro-4/
  #
temperatures = collect(LinRange(0.1, 1.0, 5));  # This is beta = 1/T
mh_sigmas = collect(LinRange(0.75, 0.15, 5));  # stepsize
# mh_sigmas = [2.75 2.5 2.0 1.75 1.6]  # used as stepsizes
    # low temperature should have a larger stepsize
chain_n = length(temperatures);  # number of replicas
replica_chainID = [i  for i in 1:chain_n];  # replica_chainID[1] = the chain ID that the first replica uses
niter = 10000;

# Functions
function log_llk(x, temperature = 1.0)
    llk = Array{Float64}(undef, K_true);

    for k in 1:K_true
        llk[k] = log(Z_prob[k]) + loglikelihood(Normal(mu_true[k], tSigma[k]), x);
    end
    llksum = temperature * logsumexp(llk)
    return(llksum)
end

# Sampling Functions
function sampling(niter, temperatures, replica::Bool = true, auto_temp::Bool = true)
  points = Array{Float64}(undef, chain_n, niter);
  accept = zeros(Int16, chain_n, 2);
  swap_accepted = zeros(Int16, chain_n-1);
  swap_proposed = zeros(Int16, chain_n-1);

  # Initialization
  replica_chainID = [i  for i in 1:chain_n];
  for chain_id in 1:chain_n
      points[chain_id, 1] = mu_true[rand(1:K_true)]
  end

  # Iteration
  for iter in 2:niter
      for replica_index in replica_chainID
          chain_id = replica_chainID[replica_index]
          if replica
            temperature = temperatures[replica_index]
          else
            temperature = 1.0
        end
          mh_sigma = mh_sigmas[replica_index]

          points, accept = sampling_points(points, accept, iter, chain_id, temperature, mh_sigma)
      end

      if replica && iter % 5 == 0
          replica_chainID, swap_accepted, swap_proposed = replica_exchange(iter, replica_chainID, temperatures, points, swap_accepted, swap_proposed)
      end

      if replica && auto_temp && iter % 10 == 0
        temperatures = temperatures_adjust(iter, temperatures, swap_accepted, swap_proposed)
      end
  end

  return(points, accept, temperatures)
end


function temperatures_adjust(iter, temperatures, swap_accepted, swap_proposed)
  ratios = swap_accepted ./ swap_proposed
  # walker = chain_n;  # n_w
  walker = 1;  # a single chain per temperature
  v = 10^2 / walker
  t0 = 10^3 / walker
  kappa = 1/v * t0 / (iter + t0)

  dSs = kappa * (ratios[1:(length(ratios)-1)] - ratios[2:length(ratios)])  # Eq.13
  deltaTs = diff(1 ./ temperatures[1:(length(temperatures) - 1)])
  deltaTs .*= exp.(dSs)

  temperatures[2:(length(temperatures) - 1)] = 1 ./ (cumsum(deltaTs) .+ 1 / temperatures[1])

  return(temperatures)
end


function replica_exchange(iter, replica_chainID, temperatures, points, swap_accepted, swap_proposed)
  n_temperatures = length(replica_chainID)

  if iter % 2 == 0
      candidates = collect(StepRange(2, 2, n_temperatures))
  else
      candidates = collect(StepRange(1, 2, n_temperatures))
  end

  for val in candidates
      # Make a pair
      if val != maximum(replica_chainID)
          i = val
          j = val + 1
      else
          break
      end

      # Get temperature
      bi = temperatures[i]
      bj = temperatures[j]

      # Which chain each replica uses
      chain_i = replica_chainID[i]
      chain_j = replica_chainID[j]

      # log-likelihood (multiply temperature later)
      llk_i = log_llk(points[chain_i, iter], 1.0)
      llk_j = log_llk(points[chain_j, iter], 1.0)

      # acceptance
      r = min(0, bi * llk_j - bi * llk_i + bj * llk_i - bj * llk_j)
      u = log(rand())

      if u < r
          replica_chainID[i] = chain_j;
          replica_chainID[j] = chain_i;

          swap_accepted[min(i, j)] += 1;
      end
      swap_proposed[min(i, j)] += 1;
  end

  return replica_chainID, swap_accepted, swap_proposed
end


function sampling_points(points, accept, iter, chain_id = 1, temperature = 1.0, mh_sigma = 1.0)

  point_current = points[chain_id, iter-1]
  llk_current = log_llk(point_current, temperature)

  point_new = (point_current + rand(Normal(0.0, mh_sigma), 1)[1])
#   point_new = point_current + rand(Uniform(- 0.5 * mh_sigma, 0.5 * mh_sigma))
  llk_new = log_llk(point_new, temperature)

  r = min(0, llk_new - llk_current)
  u = log(rand())

  if u < r
      # Accept
      points[chain_id, iter] = point_new
      accept[chain_id, 1] += 1
  else
      # Reject
      points[chain_id, iter] = point_current
      accept[chain_id, 2] += 1
  end

  return points, accept
end

# Visualize
function visualize(points, chain_id, savename)
  p = plot(
      layer(x = points[chain_id, floor(Int, niter/3):niter], Geom.density),
      Coord.cartesian(xmin=val_min * 1.05, xmax=val_max * 1.05),
      Scale.x_continuous(minvalue=val_min, maxvalue=val_max),
      Guide.title("Chain: $chain_id")
  )
#   draw(PDF(savename, 4inch, 4inch), p)
  return p
end

# With Replica
temperatures = collect(LinRange(0.1, 1.0, 5));  # This is beta = 1/T
points, accept, temperatures_adjusted1 = sampling(niter, temperatures);
p1 = visualize(points, 1, "1Dreplica_1.pdf");
p2 = visualize(points, 2, "1Dreplica_2.pdf");
p3 = visualize(points, 3, "1Dreplica_3.pdf");
p4 = visualize(points, 4, "1Dreplica_4.pdf");
p5 = visualize(points, 5, "1Dreplica_5.pdf");
p = vstack(p1, p2, p3, p4, p5);
draw(PDF("1Dreplica_AutoTemperature.pdf", 4inch, 12inch), p);

# Without automatically adjusting temperature
temperatures = collect(LinRange(0.1, 1.0, 5));  # This is beta = 1/T
points, accept, temperatures_adjusted2 = sampling(niter, temperatures, true, false);
p1 = visualize(points, 1, "1Dreplica_1.pdf");
p2 = visualize(points, 2, "1Dreplica_2.pdf");
p3 = visualize(points, 3, "1Dreplica_3.pdf");
p4 = visualize(points, 4, "1Dreplica_4.pdf");
p5 = visualize(points, 5, "1Dreplica_5.pdf");
p = vstack(p1, p2, p3, p4, p5);
draw(PDF("1Dreplica.pdf", 4inch, 12inch), p);

# Without Replica
temperatures = collect(LinRange(0.1, 1.0, 5));  # This is beta = 1/T
points_n, accept_n, temperatures_adjusted3 = sampling(niter, temperatures, false);
p1 = visualize(points_n, 1, "1Dno_replica_1.pdf");
p2 = visualize(points_n, 2, "1Dno_replica_2.pdf");
p3 = visualize(points_n, 3, "1Dno_replica_3.pdf");
p4 = visualize(points_n, 4, "1Dno_replica_4.pdf");
p5 = visualize(points_n, 5, "1Dno_replica_5.pdf");
p = vstack(p1, p2, p3, p4, p5);
draw(PDF("1Dno_replica.pdf", 4inch, 12inch), p);

