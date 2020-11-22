from pydicom import dcmread
import matplotlib.pyplot as plt
import os

root = '/Users/oliviagallup/Downloads/10693701'
root2 = '/Users/oliviagallup/Downloads/10693702'
for root, dirs, files in os.walk(root):
    for filename in files:
        filename = os.path.join(root, filename)


        dataset = dcmread(filename)
        print(dataset.PatientID)

        # print(dataset)

        plt.imshow(dataset.pixel_array, cmap=plt.cm.bone)
        # plt.show()
