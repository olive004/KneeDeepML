# Random tests of Segmentation files


""" [Test] Loss works with 2D and 3D """
import numpy as np
import tensorflow.keras.backend as K
import tensorflow as tf

# toy_sample_3d = np.random.randint(0, 5, size=(3,3,3,7))
# toy_pred_3d = np.random.randint(0, 5, size=(3,3,3,7))
toy_sample_2d = np.random.randint(0, 5, size=(3,3,7))
toy_pred_2d = np.random.randint(0, 5, size=(3,3,7))
toy_sample_3d = np.expand_dims(toy_sample_2d, axis=2)
toy_sample_3d = np.pad(toy_sample_3d, ((0,0),(0,0),(0,2),(0,0)), mode='constant', constant_values=0)
toy_pred_3d = np.expand_dims(toy_pred_2d, axis=2)
toy_pred_3d = np.pad(toy_pred_3d, ((0,0),(0,0),(0,2),(0,0)), mode='constant', constant_values=0)

toy_sample_3d = tf.convert_to_tensor(toy_sample_3d, dtype=tf.float32)
toy_pred_3d = tf.convert_to_tensor(toy_pred_3d, dtype=tf.float32)
toy_sample_2d = tf.convert_to_tensor(toy_sample_2d, dtype=tf.float32)
toy_pred_2d = tf.convert_to_tensor(toy_pred_2d, dtype=tf.float32)

def tversky_loss(y_true, y_pred, alpha=0.5, beta=0.5, smooth=1e-10):
    """ Tversky loss function.
    Parameters
    ----------
    y_true : tensor containing target mask.
    y_pred : tensor containing predicted mask.
    alpha : real value, weight of '0' class.
    beta : real value, weight of '1' class.
    smooth : small real value used for avoiding division by zero error.
    Returns
    -------
    tensor
        tensor containing tversky loss.
    """
    y_true = K.flatten(y_true)
    y_pred = K.flatten(y_pred)
    truepos = K.sum(y_true * y_pred)
    fp_and_fn = alpha * K.sum(y_pred * (1 - y_true)) + beta * K.sum((1 - y_pred) * y_true)
    answer = (truepos + smooth) / ((truepos + smooth) + fp_and_fn)

    return 1 - answer

tv_loss_3d = tversky_loss(toy_sample_3d, toy_pred_3d)
tv_loss_2d = tversky_loss(toy_sample_2d, toy_pred_2d)

print('Loss accepts 2d & 3d:', tv_loss_3d == tv_loss_2d)

