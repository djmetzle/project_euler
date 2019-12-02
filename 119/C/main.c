#include <stdio.h>
#include <stdbool.h>

unsigned long digitsum(unsigned long n) {
   unsigned long m, sum = 0;
   while (n>0) {
      m = n % 10;
      sum += m;
      n = n/10;
   }
   return sum;
}

bool power_sum(unsigned long n) {
   bool is_power_sum = false;
   unsigned long digit_sum = digitsum(n);
   if (digit_sum == 1) return false;
   unsigned long power = 1;
   while (true) {
      power *= digit_sum;
      if (power == n) {
         is_power_sum = true;
      }
      if (power >= n) {
         break;
      }
   }
   return is_power_sum;
}

int main() {
   unsigned long MAX = 30;

   int found = 0;
   unsigned long test_n = 11;

   while (true) {
      if (power_sum(test_n)) {
         found += 1;
         printf("%d : %lu\n", found, test_n);
      }
      if (found >= MAX) {
         break;
      }
      test_n += 1;
   }

   return 0; 
}
