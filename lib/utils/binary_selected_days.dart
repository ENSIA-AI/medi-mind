int getSelectedDaysCount(int selectedDaysRepresentation){
  return countSetBits(selectedDaysRepresentation);
}

int countSetBits(int n) {
  int count = 0;
  while (n > 0) {
    count += n & 1;  // Check least significant bit
    n >>= 1;         // Right shift to check next bit
  }
  return count;
}