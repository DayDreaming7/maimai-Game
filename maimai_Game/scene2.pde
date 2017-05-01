void scene2Update() {
  updateMainRing();
  displayAllTabs();


  for (HitPoint temp : hitPoints) {
    temp.display();
  }
}