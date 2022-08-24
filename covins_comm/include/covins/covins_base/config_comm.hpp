#pragma once

#include <string>
#include "typedefs_base.hpp"

namespace covins_params {
    using precision_t = covins::TypeDefs::precision_t;

bool LoadConfigFile(const std::string& config_file);

namespace sys {
    std::string server_ip;
    std::string port;
}

namespace comm {
    bool send_updates;
    bool data_to_client;
    int start_sending_after_kf;
    int kf_buffer_withold;
    int max_sent_kfs_per_iteration;
    int update_window_size;
    precision_t to_agent_freq;
    precision_t start_drift_estimation_after_kf;
}

namespace orb {
    bool activate_visualization;
    precision_t imu_stamp_max_diff;
}

void ShowParamsComm();
std::string GetServerIP();
std::string GetPort();

} // namespace covins_params