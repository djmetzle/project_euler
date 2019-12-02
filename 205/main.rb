#!/usr/bin/ruby

# Euler 205

n_f = 4
n_d = 9

m_f = 6
m_d = 6

n_base_prob = Rational(1,n_f)
m_base_prob = Rational(1,m_f)

n_probs = {}
m_probs = {}

(1..n_f).each {|i| n_probs[i] = n_base_prob }
(1..m_f).each {|i| m_probs[i] = m_base_prob }

p n_probs
p m_probs
