#include <iostream>
#include <vector>
#include <string>

// 计算两个数的和
int add(int a, int b) {
    int result = a + b;
    return result;
}

// 计算阶乘
int factorial(int n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

// 测试类
class Calculator {
private:
    std::string name;
    
public:
    Calculator(std::string n) : name(n) {}
    
    int multiply(int a, int b) {
        return a * b;
    }
    
    void printName() {
        std::cout << "Calculator: " << name << std::endl;
    }
};

int main() {
    std::cout << "=== C++ 调试测试 ===" << std::endl;
    
    // 测试加法
    int x = 10;
    int y = 20;
    int sum = add(x, y);
    std::cout << x << " + " << y << " = " << sum << std::endl;
    
    // 测试阶乘
    int n = 5;
    int fact = factorial(n);
    std::cout << "factorial(" << n << ") = " << fact << std::endl;
    
    // 测试类
    Calculator calc("MyCalc");
    calc.printName();
    int product = calc.multiply(4, 5);
    std::cout << "4 * 5 = " << product << std::endl;
    
    // 测试向量
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    std::cout << "Numbers: ";
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    std::cout << "完成！" << std::endl;
    return 0;
}
