# ---------------------------------------------------
# STEP 1: Import Required Libraries
# ---------------------------------------------------
import os
import matplotlib.pyplot as plt
from PIL import Image, ImageOps   # Pillow library for image loading and manipulation
from scipy.ndimage import rotate  # For rotation
import numpy as np                # For handling arrays

# ---------------------------------------------------
# STEP 2: Upload kaggle.json for dataset access
# ---------------------------------------------------
# This will open a file picker in Google Colab to upload kaggle.json
# # Create the .kaggle folder if it does not exist
#os.makedirs(os.path.expanduser("~/.kaggle"), exist_ok=True)

# # If your kaggle.json is in your project folder, copy it into ~/.kaggle/
# import shutil
# shutil.copy("kaggle.json", os.path.expanduser("~/.kaggle/kaggle.json"))

# Set correct permissions (important on Linux/Mac)
#os.chmod(os.path.expanduser("~/.kaggle/kaggle.json"), 0o600)

# ---------------------------------------------------
# STEP 2: Download dataset using Kaggle API
# ---------------------------------------------------
#!kaggle datasets download -d olgabelitskaya/flower-color-images

# ---------------------------------------------------
# STEP 3: Unzip dataset
# ---------------------------------------------------
#!unzip -q flower-color-images.zip

# ---------------------------------------------------
# STEP 3: Configure Kaggle credentials
# ---------------------------------------------------
# Create a hidden directory to store kaggle.json
#!mkdir -p ~/.kaggle
#!cp kaggle.json ~/.kaggle/
#!chmod 600 ~/.kaggle/kaggle.json  # Set correct permissions for security

# ---------------------------------------------------
# STEP 4: Download the Flower Color Images dataset from Kaggle
# ---------------------------------------------------
#!kaggle datasets download -d olgabelitskaya/flower-color-images

# ---------------------------------------------------
# STEP 5: Unzip the dataset
# ---------------------------------------------------
#!unzip -q flower-color-images.zip

# ---------------------------------------------------
# STEP 6: Install required libraries
# ---------------------------------------------------
#pip install tensorflow keras pillow

# ---------------------------------------------------
# STEP 7: Load and Display an Image

# ---------------------------------------------------
# Select a sample image path from the dataset
dir_path = os.path.dirname(os.path.realpath(__file__))
image_path = os.path.join(dir_path, "flowers/flowers/19_010.png")

# Open the image using PIL
original_image = Image.open(image_path)

# Display the original image using matplotlib
plt.imshow(original_image)
plt.title("Original Image")
plt.axis("off")  # Hide axis for clarity
plt.show()

# ---------------------------------------------------
# STEP 8: Rotate Image by 30 Degrees
# ---------------------------------------------------
def rotate_image_30_degrees(image):
    """
    Rotates the input image by 30 degrees using scipy.ndimage.rotate
    Input: PIL image
    Output: Rotated NumPy array
    """
    # Convert PIL Image to NumPy array before using scipy rotate
    img_array = np.array(image)
    rotated_array = rotate(img_array, 30, reshape=False)  # reshape=False keeps image size unchanged
    return rotated_array

# Rotate and display
rotated_img = rotate_image_30_degrees(original_image)
plt.imshow(rotated_img)
plt.title("Rotated Image (30 degrees)")
plt.axis("off")
plt.show()

# ---------------------------------------------------
# STEP 9: Flip Image Horizontally and Vertically
# ---------------------------------------------------
# Flip horizontally (mirror effect)
flipped_horizontally = ImageOps.mirror(original_image)

# Flip vertically (upside down)
flipped_vertically = ImageOps.flip(original_image)

# Display results
fig, axs = plt.subplots(1, 2, figsize=(10, 5))
axs[0].imshow(flipped_horizontally)
axs[0].set_title("Flipped Horizontally")
axs[0].axis("off")

axs[1].imshow(flipped_vertically)
axs[1].set_title("Flipped Vertically")
axs[1].axis("off")

plt.show()

# ---------------------------------------------------
# STEP 10: Zoom Image (Scale by 1.2x)
# ---------------------------------------------------
def zoom_image(image, scale=1.2):
    """
    Zooms the image by scaling with a given factor.
    Input: PIL image
    Output: Zoomed PIL image
    """
    # Get current dimensions
    width, height = image.size
    # Calculate new dimensions
    new_width, new_height = int(width * scale), int(height * scale)
    # Resize image
    zoomed_image = image.resize((new_width, new_height), Image.Resampling.LANCZOS)
    return zoomed_image

# Apply zoom and display
zoomed_img = zoom_image(original_image, 1.2)
plt.imshow(zoomed_img)
plt.title("Zoomed Image (1.2x)")
plt.axis("off")
plt.show()
