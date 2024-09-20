# *Friday Night at Penn*

*For instructions, consult the [CIS 1951 website](https://www.seas.upenn.edu/~cis1951/24fa/assignments/hw/hw1).*

## Explanations

**What locations/rooms does your game have?**

1. Locust
2. Ksig
3. Fiji
4. PhiPsi
5. Castle


**What items does your game have?**

1. Casey (girl with the info on Castle backdoor)
2. John (Castle doorguard)
3. Annie (the abg)

**Explain how your code is designed. In particular, describe how you used structs or enums, as well as protocols.**

In this code, I use Swift's structs, enums, and protocols for clarity and modularity. Enums like Direction define possible user inputs (east, west, south, north, and talk), simplifying command parsing. Protocols Location and Person establish blueprints for game locations and characters, ensuring consistent implementation across different structs and allowing a generic type to be passed in the game state object. Structs like Annie, John, and Casey conform to Person, representing characters with specific attributes and behaviors. Location structs like Locust, PhiPsi, and Castle conform to Location, each defining unique settings, descriptions, and possible exits. The main game logic is handled by the game state struct, which manages the game's state, current location, and user interactions.

**How do you use optionals in your program?**

In this project I used Optionals to safely handle the presence or absence of values. The person property in the Location protocol is an optional (Person?), as not all locations have a character to interact with. When the player chooses to "talk," the game uses optional binding (if let) to check if a person exists at the current location before proceeding, thus avoiding potential runtime errors due to nil values.

**What extra credit features did you implement, if any?**

None

## Endings

### Ending 1: Got in to Castle and had a great night

```
west, talk, east, south
```

### Ending 2: Kicked out of Castle and went home to cry

```
south, talk
```

### Ending 3: Sleepover with the abg

```
east, talk
```
