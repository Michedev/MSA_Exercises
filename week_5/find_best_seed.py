from sklearn.linear_model import LinearRegression
from scipy.stats import norm, uniform
import numpy as np
from joblib import Parallel, delayed

best_coef = np.array([-0.97, 0.146, 0.027, 0.227])


def gen_data(seed=13):
    x1 = uniform.rvs(0, 1, size=150, random_state=seed)
    x2 = x1 + uniform.rvs(0, 1, size=150, random_state=seed)
    x3 = uniform.rvs(0, 1, size=150, random_state=seed)
    y = []
    for i in range(len(x1)):
        y.append(norm.rvs(-1 + 0.3 * x1[i] + 0.2 * x3[i], 0.2 ** 2, random_state=seed))
    return np.matrix([y, x1, x2, x3])


def gen_data_and_fit(seed):
    data = gen_data(seed)
    X, y = data[1:, :].transpose(), data[0, :].transpose()
    lm: LinearRegression = LinearRegression()
    lm.fit(X, y)
    return lm


def find_best_seed():
    return min(range(1_020_000, 1_060_000), key=distance_from_best_coef)


def get_coef(seed):
    lm = gen_data_and_fit(seed)
    return np.append(lm.intercept_, lm.coef_)


def distance_from_best_coef(seed):
    lm = gen_data_and_fit(seed)
    return np.linalg.norm(np.append(lm.intercept_, lm.coef_) - best_coef)


print(find_best_seed())
# print(get_coef(122009))
