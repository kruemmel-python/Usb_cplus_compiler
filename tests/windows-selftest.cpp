#include <iostream>

consteval int answer() {
    return 6 * 7;
}

int main() {
    static_assert(answer() == 42);
    std::cout << "KR_WINDOWS_OK=" << answer() << '\n';
    return answer() == 42 ? 0 : 1;
}
