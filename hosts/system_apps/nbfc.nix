{ config, pkgs, ... }:

let
  # Import the NBFC NixOS module
  nbfc-linux = builtins.fetchGit {
    url = "https://github.com/nbfc-linux/nbfc-linux.git";
    ref = "main";
  };
in {
  imports = [ "${nbfc-linux}/nixos" ];

  # Enable NBFC service  
  services.nbfc = {
    enable = true;
    config = "predator_neo16_phn16-71";
  };

  # Add your custom profile
  environment.etc."nbfc/configs/predator_neo16_phn16-71.json".text = ''
    {
      "LegacyTemperatureThresholdsBehaviour": true,
      "NotebookModel": "Predator Neo16 PHN16-71",
      "Author": "Custom Profile",
      "EcPollInterval": 100,
      "ReadWriteWords": false,
      "CriticalTemperature": 90,
      "FanConfigurations": [
        {
          "ReadRegister": 55,
          "WriteRegister": 55,
          "MinSpeedValue": 0,
          "MaxSpeedValue": 100,
          "IndependentReadMinMaxValues": true,
          "MinSpeedValueRead": 0,
          "MaxSpeedValueRead": 4500,
          "ResetRequired": true,
          "FanSpeedResetValue": 50,
          "FanDisplayName": "CPU Fan",
          "TemperatureThresholds": [
            {
              "UpThreshold": 45,
              "DownThreshold": 0,
              "FanSpeed": 25.0
            },
            {
              "UpThreshold": 60,
              "DownThreshold": 46,
              "FanSpeed": 50.0
            },
            {
              "UpThreshold": 75,
              "DownThreshold": 61,
              "FanSpeed": 75.0
            },
            {
              "UpThreshold": 85,
              "DownThreshold": 76,
              "FanSpeed": 100.0
            }
          ]
        },
        {
          "ReadRegister": 58,
          "WriteRegister": 58,
          "MinSpeedValue": 0,
          "MaxSpeedValue": 100,
          "IndependentReadMinMaxValues": true,
          "MinSpeedValueRead": 0,
          "MaxSpeedValueRead": 5000,
          "ResetRequired": true,
          "FanSpeedResetValue": 50,
          "FanDisplayName": "GPU Fan",
          "TemperatureThresholds": [
            {
              "UpThreshold": 50,
              "DownThreshold": 0,
              "FanSpeed": 30.0
            },
            {
              "UpThreshold": 65,
              "DownThreshold": 51,
              "FanSpeed": 60.0
            },
            {
              "UpThreshold": 80,
              "DownThreshold": 66,
              "FanSpeed": 85.0
            },
            {
              "UpThreshold": 90,
              "DownThreshold": 81,
              "FanSpeed": 100.0
            }
          ]
        }
      ],
      "RegisterWriteConfigurations": [
        {
          "WriteMode": "Set",
          "WriteOccasion": "OnInitialization",
          "Register": 34,
          "Value": 92,
          "ResetRequired": true,
          "ResetValue": 84,
          "ResetWriteMode": "Set",
          "Description": "CPU fan manual mode"
        },
        {
          "WriteMode": "Set",
          "WriteOccasion": "OnInitialization",
          "Register": 33,
          "Value": 112,
          "ResetRequired": true,
          "ResetValue": 80,
          "ResetWriteMode": "Set",
          "Description": "GPU fan manual mode"
        },
        {
          "WriteMode": "Set",
          "WriteOccasion": "OnInitialization",
          "Register": 16,
          "Value": 0,
          "ResetRequired": true,
          "ResetValue": 1,
          "ResetWriteMode": "Set",
          "Description": "CoolBoost off"
        }
      ]
    }
  '';
}
