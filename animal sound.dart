class Animal {
  void makeSound() {
    print('Some generic animal sound');
  }
}

class Dog extends Animal {
  void makeSound() {
    print('Bark');
  }
}

void main() {
  Dog myDog = Dog();
  myDog.makeSound();
}
