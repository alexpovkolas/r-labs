#include <Rcpp.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//
int gcd(int m, int n){
  if (n == 0) {
    return m;
  } else if (m == 0) {
    return n;
  } else if (n == 1 || m == 1) {
    return 1;
  } else if (n == m) {
    return n;
  }
  
  bool nEven = n % 2 == 0;
  bool mEven = m % 2 == 0;
  if (nEven && mEven) {
    return 2 * gcd(m/2, n/2);
  } else if (mEven && !nEven) {
    return gcd(m/2, n);
  } else if (!mEven && nEven) {
    return gcd(m, n/2);
  } else if (!mEven && !nEven && n > m) {
    return gcd((n-m) / 2, m);
  } else {
    return gcd((m-n) / 2, n);
  }
}

//[[Rcpp::export]]
int gcd_v_cpp(NumericVector args){
  int res = args[0];
  for (int i = 1; i < args.size(); ++i) {
    res = gcd(res, args[i]);
  }
  return res;
}


