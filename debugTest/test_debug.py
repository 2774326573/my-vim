#!/usr/bin/env python3

def add(a, b):
    result = a + b
    return result

def main():
    x = 5
    y = 10
    z = add(x, y)
    print(f"Result: {z}")
    
    # 测试循环
    for i in range(3):
        print(f"Loop {i}")

if __name__ == "__main__":
    main()
