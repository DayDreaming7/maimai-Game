void update() {
  updateMainRing();
  displayAllTabs();


  for (HitPoint temp : hitPoints) {
    temp.display();
  }
}