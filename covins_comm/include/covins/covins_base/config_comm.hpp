#pragma once

#include <string>
#include "typedefs_base.hpp"

namespace covins_params {
    using precision_t = covins::TypeDefs::precision_t;

bool LoadConfigFile(const std::string& config_file);

namespace sys {
    static std::string server_ip;
    static std::string port;
}

namespace comm {
    static bool send_updates;
    static bool data_to_client;
    static int start_sending_after_kf;
    static int kf_buffer_withold;
    static int max_sent_kfs_per_iteration;
    static int update_window_size;
    static precision_t to_agent_freq;
    static precision_t start_drift_estimation_after_kf;
}

namespace orb {
    static bool activate_visualization;
    static precision_t imu_stamp_max_diff;
}

void ShowParamsComm();
std::string GetServerIP();
std::string GetPort();

} // namespace covins_params