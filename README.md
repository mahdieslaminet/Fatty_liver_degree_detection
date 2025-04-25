# Fatty_liver_degree_detection
Fatty liver degree detection using convolutional networks and texture information from ultrasound images

> 𝐄𝐧𝐠:
# README: Fatty Liver Disease Detection Using Convolutional Neural Networks (CNNs) and Ultrasound Images

## Project Overview
This project focuses on diagnosing the degree of fatty liver disease using deep learning techniques, specifically Convolutional Neural Networks (CNNs), combined with texture analysis of ultrasound images. The goal is to classify liver conditions into four categories: healthy (fat content < 5%), Grade 1 (5-20% fat), Grade 2 (20-40% fat), and Grade 3 (>40% fat). The system leverages pre-processing techniques like Gabor filters and Gray-Level Co-occurrence Matrix (GLCM) to extract texture features, followed by classification using various CNN architectures.

### Key Features:
- Deep Learning Models: Utilizes CNNs, including custom designs and well-known architectures like AlexNet, VGG16, GoogleNet, and ResNet.
- Texture Analysis: Employs Gabor filters and GLCM to enhance feature extraction from ultrasound images.
- High Accuracy: Achieves up to 99.7% accuracy in binary classification (healthy vs. diseased) and 98.7% in four-class classification.
- Non-Invasive Diagnosis: Provides a reliable alternative to invasive biopsy methods.

---

## Dataset Description
The dataset used in this project consists of ultrasound images collected from 55 patients with severe obesity (average BMI: 45.9 ± 5.6). The data was obtained from the Medical University of Warsaw, Poland, and includes the following:

### Dataset Details:
- Source: Ultrasound images (B-mode) captured using a GE Vivid E9 system.
- Resolution: 434 × 636 pixels (0.373 mm/pixel).
- Image Sequences: 10 consecutive images per patient, totaling 550 images.
- Labels: Histopathological biopsy results categorize the liver condition into four grades based on fat percentage:
  - Healthy: <5% fat
  - Grade 1: 5-20% fat
  - Grade 2: 20-40% fat
  - Grade 3: >40% fat

### Data Distribution:
| Class          | Number of Samples |
|----------------|-------------------|
| Healthy        | 170               |
| Grade 1        | 130               |
| Grade 2        | 120               |
| Grade 3        | 130               |

### Preprocessing:
1. Region of Interest (ROI) Extraction: Manual and automated methods to isolate relevant liver regions.
2. Texture Feature Extraction: Gabor filters and GLCM are applied to capture tissue characteristics.
3. Data Augmentation: Overlapping patches are extracted to increase the dataset size artificially (from 550 to 9900 samples).

### Access:
The dataset is publicly available on [Zenodo](https://zenodo.org/). It includes ultrasound image sequences and corresponding biopsy results, making it valuable for researchers in medical imaging and machine learning.

---

## Methodology
1. Preprocessing:
   - Extract ROIs from ultrasound images.
   - Apply Gabor filters and GLCM to highlight texture features.
2. Model Training:
   - Train multiple CNN architectures (custom and pre-trained).
   - Evaluate performance using accuracy, confusion matrices, and loss curves.
3. Classification:
   - Binary classification: Healthy vs. Diseased.
   - Multi-class classification: Four grades of fatty liver.

### Results:
- Best Binary Classifier: VGG16 (99.7% training, 99.4% test accuracy).
- Best Multi-Class Classifier: AlexNet (98.3% training, 98.7% test accuracy).

---

## How to Use This Project
1. Clone the Repository:
  
   git clone [repository-link]
   
2. Install Dependencies:
   - MATLAB 2020b or later (with Deep Learning and Signal Processing Toolboxes).
   - Python libraries (if using alternative implementations): TensorFlow, Keras, OpenCV.
3. Run the Code:
   - Execute the MATLAB scripts for preprocessing, training, and evaluation.
   - Modify parameters in config.m for custom experiments.

---

## Future Work
- Expand the dataset to include more diverse patient demographics.
- Explore hybrid models combining CNNs with Transformers.
- Develop a real-time diagnostic tool for clinical use.

---
https://drive.google.com/drive/folders/1uICX3nu2_tiaYy34MgYgT9dev3taACAI?usp=drive_link
VEDIO CODES


https://docs.google.com/document/d/1saHc0gF4sCHBN4PYRCUuglY5ldBsa-al/edit?usp=drive_link&ouid=101046966974993099608&rtpof=true&sd=true
مقاله


https://drive.google.com/file/d/1OryiQ_95BCUdTMVmQ7yZOa7SQe5GzOzu/view?usp=drive_link
VEDIO AHMED JASIM


https://docs.google.com/document/d/1RSEtt85qVBoVkivfMnabVepMH7lD0Cqv/edit?usp=drive_link&ouid=101046966974993099608&rtpof=true&sd=true
بروبوزال


https://drive.google.com/file/d/1OpjvAWQNzNKSXjtCf3uJt5kJ4kCHEV9R/view?usp=drive_link
بيان نامه


https://drive.google.com/file/d/1SzQHZiX608QHDPmXvaDEKfvo72xJF1-b/view?usp=drive_link
CODE
