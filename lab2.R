gcd <- function(n, m) {
  if (n == 0) {
    return(m)
  } else if (m == 0) {
    return(n)
  } else if (n == 1 || m == 1) {
    return(1)
  } else if (n == m) {
    return(n)
  }
  
  nEven = n %% 2 == 0
  mEven = m %% 2 == 0
  if (nEven && mEven) {
    return(2 * gcd(m/2, n/2))
  } else if (mEven && !nEven) {
    return(gcd(m/2, n))
  } else if (!mEven && nEven) {
    return(gcd(m, n/2))
  } else if (!mEven && !nEven && n > m) {
    return(gcd((n-m) / 2, m))
  } else {
    return(gcd((m-n) / 2, n))
  }
}

gcd_v <- function(...) {
  args <- c(...)
  return (Reduce(gcd, args, args[1]))
}

gcd(1071, 462) == 21

(gcd_v(1071, 462, 42, 84))
