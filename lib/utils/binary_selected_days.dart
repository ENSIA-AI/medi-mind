int getSelectedDaysCount(int selectedDaysRepresentation){
  return countSetBits(selectedDaysRepresentation);
}

Set<int> getSelectedDays(int binaryRepresentation) {
  Set<int> selectedDays = {};
  for (int i = 0; i < 7; i++) {
    if ((binaryRepresentation & (1 << i)) != 0) {
      selectedDays.add(i);
    }
  }
  return selectedDays;
}

int countSetBits(int n) {
  int count = 0;
  while (n > 0) {
    count += n & 1;  // Check least significant bit
    n >>= 1;         // Right shift to check next bit
  }
  return count;
}