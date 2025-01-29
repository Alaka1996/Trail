#include <gtest/gtest.h>
extern "C" {
    #include "main.c"  // Include your C file
}

// Test for calculate_average
TEST(SensorDataTest, CalculateAverage) {
    uint16_t data[BUFFER_SIZE] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
    int avg = calculate_average(data, BUFFER_SIZE);
    EXPECT_EQ(avg, 55);  // Expect the average to be 55
}

// Test for process_data (printed output check)
TEST(SensorDataTest, ProcessData) {
    uint16_t data[BUFFER_SIZE] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
    testing::internal::CaptureStdout();
    process_data(data);
    std::string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Average sensor value: 55") != std::string::npos);
    EXPECT_TRUE(output.find("Sensor value is within safe range.") != std::string::npos);
}

// Test for read_sensor_data (ensuring values are within bounds)
TEST(SensorDataTest, ReadSensorData) {
    uint16_t data[BUFFER_SIZE];
    read_sensor_data(data);
    for (int i = 0; i < BUFFER_SIZE; i++) {
        EXPECT_GE(data[i], 0);
        EXPECT_LT(data[i], 1024);  // Data should be in range [0, 1023]
    }
}
