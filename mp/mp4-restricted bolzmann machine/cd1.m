function ret = cd1(rbm_w, visible_data)
% <rbm_w> is a matrix of size <number of hidden units> by <number of visible units>
% <visible_data> is a (possibly but not necessarily binary) matrix of size <number of visible units> by <number of data cases>
% The returned value is the gradient approximation produced by CD-1. It's of the same shape as <rbm_w>.

  %% this operation will trun the real value into binary data.
  visible_data = sample_bernoulli(visible_data);

  hidden_probs = visible_state_to_hidden_probabilities(rbm_w, visible_data);
  hidden_state = sample_bernoulli(hidden_probs);

  initial = configuration_goodness_gradient(visible_data, hidden_state);

  bp_visible_probs = hidden_state_to_visible_probabilities(rbm_w, hidden_state);
  bp_visible_states = sample_bernoulli(bp_visible_probs);
  new_hidden_probs = visible_state_to_hidden_probabilities(rbm_w, bp_visible_states);


  %% this is  unoptmized version.
  % new_hidden_states = sample_bernoulli(new_hidden_probs);
  % reconstruction = configuration_goodness_gradient(bp_visible_states, new_hidden_states);

  %% this is optmized version, quiz 8:
  reconstruction = configuration_goodness_gradient(bp_visible_states, new_hidden_probs);

  ret = initial .- reconstruction;
end
