import numpy as np
from scipy.misc import imsave
from scipy.ndimage import imread
import sys

def get_histogram(img):
  '''
  calculate the normalized histogram of an image
  '''

  #print(img, "\n\n\n")
  height = img.shape[0]
  width = img.shape[1]

  hist = [0.0 for _ in range(256)]
  hist = np.array(hist)

  for i in range(height):
    for j in range(width):
      hist[img[i, j]]+=1
  return np.array(hist)/(height*width)

def get_cumulative_sums(hist):
  '''
  find the cumulative sum of a numpy array
  '''
  return [sum(hist[:i+1]) for i in range(len(hist))]

def normalize_histogram(img):
  # calculate the image histogram
  hist = get_histogram(img)
  # get the cumulative distribution function
  cdf = np.array(get_cumulative_sums(hist))
  # determine the normalization values for each unit of the cdf
  sk = np.uint8(255 * cdf)
  # normalize the normalization values
  height = img.shape[0]
  width = img.shape[1]
  Y = np.zeros_like(img)
  for i in range(0, height):
    for j in range(0, width):
      Y[i, j] = sk[img[i, j]]
  # optionally, get the new histogram for comparison
  new_hist = get_histogram(Y)
  # return the transformed image
  return Y

img = imread(sys.argv[1])
#print(get_histogram(img))
normalized = normalize_histogram(img)
imsave(sys.argv[1] + '-normalized.jpg', normalized)