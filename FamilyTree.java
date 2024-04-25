import java.util.*;

public class FamilyTree {

    static class Person {
        String name;
        List<Person> parents;
        List<Person> children;

        public Person(String name) {
            this.name = name;
            this.parents = new ArrayList<>();
            this.children = new ArrayList<>();
        }

        public void addParent(Person parent) {
            this.parents.add(parent);
            parent.children.add(this);
        }

        public List<Person> getParents() {
            return parents;
        }

        public List<Person> getChildren() {
            return children;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    public static void main(String[] args) {
        // Create individuals
        Person adam = new Person("Adam");
        Person eve = new Person("Eve");
        Person cain = new Person("Cain");
        Person abel = new Person("Abel");

        // Establish relationships
        cain.addParent(adam);
        cain.addParent(eve);
        abel.addParent(adam);
        abel.addParent(eve);

        // Print family tree
        System.out.println("Family Tree:");
        printFamilyTree(adam, 0);
    }

    public static void printFamilyTree(Person person, int generation) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < generation; i++) {
            sb.append("\t");
        }
        sb.append(person.name);
        System.out.println(sb.toString());
        for (Person child : person.children) {
            printFamilyTree(child, generation + 1);
        }
    }
}
