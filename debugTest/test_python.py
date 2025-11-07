#!/usr/bin/env python3
"""Python 调试测试文件"""

def fibonacci(n):
    """计算斐波那契数列"""
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

def calculate(a, b, operation='+'):
    """简单计算器"""
    if operation == '+':
        result = a + b
    elif operation == '-':
        result = a - b
    elif operation == '*':
        result = a * b
    elif operation == '/':
        result = a / b if b != 0 else 0
    else:
        result = 0
    return result

def main():
    """主函数"""
    print("=== Python 调试测试 ===")
    
    # 测试计算
    x = 10
    y = 5
    sum_result = calculate(x, y, '+')
    print(f"{x} + {y} = {sum_result}")
    
    # 测试斐波那契
    n = 6
    fib_result = fibonacci(n)
    print(f"fibonacci({n}) = {fib_result}")
    
    # 测试循环
    numbers = [1, 2, 3, 4, 5]
    for i, num in enumerate(numbers):
        square = num ** 2
        print(f"Number {i}: {num} -> {square}")
    
    print("完成！")

if __name__ == "__main__":
    main()
