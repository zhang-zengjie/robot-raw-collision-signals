# Raw Torque Data from Collision and Contact Experiments on a KUKA Robot

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21927431.svg)](https://doi.org/10.5281/zenodo.21927431)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21941203.svg)](https://doi.org/10.5281/zenodo.21941203)
[![IEEE Dataport](https://img.shields.io/badge/IEEE-Dataport-blue)](https://ieee-dataport.org)

This repository provides MATLAB scripts and utilities for processing and extracting features from the raw torque sensor signals recorded during **robot collision** and **intentional contact** experiments on a KUKA robot arm. The accompanying datasets are publicly available on Zenodo and IEEE Dataport.

## 📖 Overview

The project aims to facilitate research in **robot physical interaction**, **collision detection**, and **reactive control** by providing:

- Raw torque sensor data from systematic collision and contact experiments.
- MATLAB scripts to parse, visualize, and extract features from the raw signals.
- Preprocessing pipelines for machine learning (e.g., classification, anomaly detection).
- Support for both classical feature engineering and deep learning (CNN/RNN) segment extraction.

These resources enable researchers to:
- Analyze collision/contact signatures under various conditions.
- Develop and benchmark algorithms for collision detection and classification.
- Design active reaction controllers for safe human–robot interaction.


## 📂 Dataset Structure

The dataset is divided into two parts, each containing 42 compressed packages:

| Part | Description | Link |
|------|-------------|------|
| **Part I: Accidental Collisions** | Unplanned, unexpected physical contacts during robot motion | [Zenodo](https://zenodo.org/records/21927431) / [IEEE Dataport](https://ieee-dataport.org/documents/raw-torque-data-collision-experiments-kuka-robot-part-i-accidental-collisions) |
| **Part II: Intentional Contacts** | Planned, deliberate physical interactions with the robot | [Zenodo](https://zenodo.org/records/21941203) / [IEEE Dataport](https://ieee-dataport.org/documents/raw-torque-data-collision-experiments-kuka-robot-part-ii-intentional-contacts) |

Each package contains time-series torque data from the robot's joint torque sensors, sampled during controlled experimental trials.


## 🔬 Related Work

This dataset has been used or referenced in the following research directions:

#### Feature Extraction & Benchmark Datasets
- **Extracted Feature Dataset** – Derived feature sets for classical ML models.
- **Collision Classification** – Supervised and unsupervised approaches to distinguish collision types.
- **Proactive Collision Reaction** – Real-time control strategies that anticipate and respond to contacts.

If you use this dataset or code in your research, please cite the relevant publications (see [Citation](#-citation)).

Refer to the following publication for details how this dataset is collected and exploited:

>  **Zhang Z**., Qian K., Schuller B. W., and Wollherr D. "*An Online Robot Collision Detection and Identification Scheme by Supervised Learning and Bayesian Decision Theory.*" IEEE Transactions on Automation Science and Engineering, 2020, 18(3): 1144–1156. [10.1109/TASE.2020.2997094](https://doi.org/10.1109/TASE.2020.2997094)


## ⚙️ Requirements

- **Operating System**: No specific OS restrictions (tested on Windows, Linux, macOS).
- **MATLAB**: No version requirement (tested on R2020b and later).
  - **Signal Processing Toolbox** – Required for filtering, segmentation, and feature extraction.


## 🚀 Installation & Setup

### 1. Download the Datasets

#### Option A: Zenodo

**Part I – Accidental Collisions**
- Download all 42 `*.tar.zst` packages from [Zenodo Part I](https://zenodo.org/records/21927431).
- Decompress using [`zstd`](https://github.com/facebook/zstd) and place the extracted folders under `%ROOT%/Collisions/`.

**Part II – Intentional Contacts**
- Download all 42 `*.tar.zst` packages from [Zenodo Part II](https://zenodo.org/records/21941203).
- Decompress and place the extracted folders under `%ROOT%/Contacts/`.

#### Option B: IEEE Dataport

**Part I – Accidental Collisions**
- Download all 42 `*.tar` packages from [IEEE Dataport Part I](https://ieee-dataport.org/documents/raw-torque-data-collision-experiments-kuka-robot-part-i-accidental-collisions).
- Extract and place the folders under `%ROOT%/Collisions/`.

**Part II – Intentional Contacts**
- Download all 42 `*.tar` packages from [IEEE Dataport Part II](https://ieee-dataport.org/documents/raw-torque-data-collision-experiments-kuka-robot-part-ii-intentional-contacts).
- Extract and place the folders under `%ROOT%/Contacts/`.

> **Note**: `%ROOT%` refers to the root directory of this repository.


### 2. Verify Directory Structure

After extraction, your folder structure should look like this:

```
./
├── README.md
├── gen_dt.m                # Main script to generate feature dataset
├── Scripts/
│   ├── example.m           # Example usage for segment extraction (CNN/RNN)
│   └── ...                 # Additional helper functions
├── PureSgn/                # (Optional) Clean reference signals
├── Collisions/             # Extracted collision experiment data
│   ├── 03-15-12-53/
│   ├── 03-15-13-08/
│   └── ...
└── Contacts/               # Extracted intentional contact experiment data
    ├── 03-22-10-45/
    ├── 03-22-10-52/
    └── ...
```


### 3. Generate the Full Feature Set

Run the main script in MATLAB to produce `full_set.csv`, which contains the comprehensive feature set combining both collision and contact data:

```matlab
gen_dt
```

This script will:
- Load all raw torque signals from `Collisions/` and `Contacts/`.
- Apply preprocessing (filtering, normalization).
- Extract statistical, spectral, and temporal features.
- Save the combined feature matrix as `full_set.csv` in the root directory.


## 📊 Advanced Usage

For deep learning workflows (CNN, RNN, LSTM), refer to:

```matlab
Scripts/example.m
```

This example demonstrates how to:
- Segment continuous torque signals into fixed-length windows.
- Extract overlapping or non-overlapping segments.
- Format data for sequence-based neural network architectures.


## 📝 Citation

If you find this dataset or code useful in your research, please cite:

> **Zhang, Z.** (2022). *Raw Torque Data from Collision Experiments on a KUKA Robot (Part I: Accidental Collisions)* [Dataset]. In An Online Robot Collision Detection and Identification Scheme by Supervised Learning and Bayesian Decision Theory (Vol. 18, Issue 3, pp. 1144–1156). Zenodo. https://doi.org/10.5281/zenodo.21927431

> **Zhang, Z.** (2022). *Raw Torque Data from Collision Experiments on a KUKA Robot (Part II: Intentional Contacts)* [Dataset]. In An Online Robot Collision Detection and Identification Scheme by Supervised Learning and Bayesian Decision Theory (Vol. 18, Issue 3, pp. 1144–1156). Zenodo. https://doi.org/10.5281/zenodo.21941203

---

## 📄 License

This project is licensed under the [MIT License](LICENSE). The dataset is provided under the terms specified by Zenodo and IEEE Dataport (typically CC BY 4.0 or similar). Please check each platform's licensing details before redistribution.

---

**Happy Researching!** 🦾