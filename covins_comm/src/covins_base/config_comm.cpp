#include <opencv2/core/core.hpp>
#include "covins/covins_base/config_comm.hpp"

namespace covins_params {

bool LoadConfigFile(const std::string &config_file) {
    cv::FileStorage fsSettings(config_file, cv::FileStorage::READ);
    if (!fsSettings.isOpened()) {
        return false;
    }

    fsSettings["sys.port"] >> covins_params::sys::port;
    fsSettings["sys.server_ip"] >> covins_params::sys::server_ip;

    fsSettings["comm.send_updates"] >> covins_params::comm::send_updates;
    fsSettings["comm.data_to_client"] >> covins_params::comm::data_to_client;
    fsSettings["comm.start_sending_after_kt"] >> covins_params::comm::start_sending_after_kf;
    fsSettings["comm.kf_buffer_withold"] >> covins_params::comm::kf_buffer_withold;
    fsSettings["comm.max_sent_kfs_per_iteration"]
            >> covins_params::comm::max_sent_kfs_per_iteration;
    fsSettings["comm.update_window_size"] >> covins_params::comm::update_window_size;
    fsSettings["comm.to_agent_freq"] >> covins_params::comm::to_agent_freq;
    fsSettings["comm.start_drift_estimation_after_kf"]
            >> covins_params::comm::start_drift_estimation_after_kf;

    fsSettings["orb.activate_visualization"] >> covins_params::orb::activate_visualization;
    fsSettings["orb.imu_stamp_max_diff"] >> covins_params::orb::imu_stamp_max_diff;

    return true;
}

auto GetPort() -> std::string {
    return covins_params::sys::port;
}

auto GetServerIP() -> std::string {
    return covins_params::sys::server_ip;
}

auto ShowParamsComm() -> void {
    std::cout << "++++++++++ System ++++++++++" << std::endl;
    std::cout << "server_ip: " << covins_params::sys::server_ip << std::endl;
    std::cout << "port: " << covins_params::sys::port << std::endl;
    std::cout << std::endl;
    std::cout << "++++++++++ Communication ++++++++++" << std::endl;
    std::cout << "send_updates: " << (int) covins_params::comm::send_updates << std::endl;
    std::cout << "data_to_client: " << (int) covins_params::comm::data_to_client << std::endl;
    std::cout << "start_sending_after_kf: " << covins_params::comm::start_sending_after_kf
              << std::endl;
    std::cout << "kf_buffer_withold: " << covins_params::comm::kf_buffer_withold << std::endl;
    std::cout << "max_sent_kfs_per_iteration: "
              << covins_params::comm::max_sent_kfs_per_iteration << std::endl;
    std::cout << "update_window_size: " << covins_params::comm::update_window_size << std::endl;
    std::cout << "to_agent_freq: " << covins_params::comm::to_agent_freq << std::endl;
    std::cout << "++++++++++ ORB-SLAM3 ++++++++++" << std::endl;
    std::cout << "activate_visualization: " << (int) covins_params::orb::activate_visualization
              << std::endl;
    std::cout << "imu_stamp_max_diff: " << covins_params::orb::imu_stamp_max_diff << std::endl;
    std::cout << std::endl;
}

} // namespace convs_params