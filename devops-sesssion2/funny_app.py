#!/usr/bin/env python3
import random
import time
import sys

def dancing_cat():
    cat1 = """
    /\\_/\\  
   ( o.o ) 
    > ^ <
  ┌─┐   ┌─┐
  │ │   │ │
  └─┘   └─┘
    """
    
    cat2 = """
    /\\_/\\  
   ( ^.^ ) 
    > v <
    ┌─┐ ┌─┐
    │ │ │ │
    └─┘ └─┘
    """
    
    return [cat1, cat2]

def funny_messages():
    return [
        "🐱 This cat has better dance moves than you! 🕺",
        "💻 Debugging: 50% coding, 50% crying, 100% confusion",
        "🍕 Pizza is just a vegetable delivery system",
        "🤖 AI will take over the world... right after it figures out CAPTCHAs",
        "☕ Coffee: Because sleep is for the weak",
        "🐛 It's not a bug, it's an undocumented feature!",
        "🎯 My code works! I have no idea why...",
        "🦄 Unicorns are real, but they only appear in error messages"
    ]

def rainbow_text(text):
    colors = ['\033[91m', '\033[92m', '\033[93m', '\033[94m', '\033[95m', '\033[96m']
    reset = '\033[0m'
    result = ""
    for i, char in enumerate(text):
        if char != ' ':
            result += colors[i % len(colors)] + char + reset
        else:
            result += char
    return result

def clear_screen():
    print('\033[2J\033[H')

def main():
    cats = dancing_cat()
    messages = funny_messages()
    
    print(rainbow_text("🎉 WELCOME TO THE FUNNY ASCII PYTHON APP! 🎉"))
    print("\n" + "="*50)
    
    try:
        for i in range(20):  # Dance for 20 cycles
            clear_screen()
            
            # Header
            print(rainbow_text("🎪 DANCING CAT EXTRAVAGANZA! 🎪"))
            print("="*50)
            
            # Dancing cat
            cat = cats[i % 2]
            print(cat)
            
            # Random funny message
            message = random.choice(messages)
            print(rainbow_text(message))
            
            # Progress bar
            progress = "█" * (i % 10 + 1) + "░" * (10 - (i % 10 + 1))
            print(f"\nDance Progress: [{progress}] {((i+1)*5)}%")
            
            # ASCII divider
            print("\n" + "~" * 50)
            print("Press Ctrl+C to stop the madness!")
            
            time.sleep(0.5)
            
    except KeyboardInterrupt:
        clear_screen()
        farewell = """
    🎭 THANKS FOR WATCHING! 🎭
        
         /\\_/\\  
        ( -.- ) 
         > ^ <   "That was exhausting..."
       ┌─┐   ┌─┐
       │ │   │ │
       └─┘   └─┘
        
    💝 Hope you enjoyed the show! 💝
        """
        print(rainbow_text(farewell))

if __name__ == "__main__":
    main()
