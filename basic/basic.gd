#!/home/abhishek/Downloads/software/godot3/Godot_v3.5.3-stable_x11.64 -s
extends SceneTree
#basics of gdscript

#variables

var a = 5
# onready var b = $Label
# onready var ball = $ground/ball
var c = "hello"
var d = true
var e = Vector2(1, 2)
var f = [1, 2, 3]
var g = {"key": "value", "key2": 100}
var h = null

#inner class

class User:
    var name = "John"
    var age = 30
    #constructor
    func _init(_name, _age):
        self.name = _name
        self.age = _age
    func print_user():
        print("Name: ", name, " Age: ", age)

#inheritance of inner class
class User2 extends User:
  func _init(_name, _age).(_name, _age):
    pass
        
#load script

var Person = load("res://basic/person.gd")

func _init():
  var user1 = User.new("Alice", 25)
  user1.print_user()

  var user2 = Person.new("abhi")
  user2.printMe()