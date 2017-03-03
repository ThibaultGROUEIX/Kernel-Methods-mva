### Kernel Ridge Regression in Matlab

Collaborative project with my friend Alexandre Hannebelle from master MVA to classify mnist using Kernel Ridge Regression.
The code is inspired from these [slides](http://lear.inrialpes.fr/people/mairal/teaching/2015-2016/MVA/fichiers/mva_slides.pdf) in the context of the course [Kernel Methods in Machine Learning](http://www.math.ens-cachan.fr/version-francaise/formations/master-mva/contenus-/kernel-methods-for-machine-learning-162157.kjsp?RH=1242430202531)(Julien Mairal (INRIA)- Jean-Philippe Vert (ENS Paris & Mines ParisTech)), of the [MVA master of ENS Cachan](http://www.cmla.ens-cachan.fr/version-anglaise/academics/mva-master-degree-227777.kjsp?RH=ACCUEIL_GB).


### Downloading the code and data:


You can clone it from GitHub as follows:

``` sh
$ git clone https://github.com/ThibaultGROUEIX/KernelMethods_mva.git
```
The data is provided with the repo.

### Run the kernel ridge regression
Just run start.m and you're set !



### Results

| Validation set | Test set      |
| -------------- | ------------- |
| 1000 images    | 10 000 images |
| 100%           | 97.78%        |

### Tricks

* HoGs feature vector concatenating cell blocks of 4x4, 7x7 and 14x14. Gradients are put in 12 bins each time.
* Jittering
* Gaussian kernel (the best among the various kernel we tested)

[![Analytics](https://ga-beacon.appspot.com/UA-91308638-2/github.com/ThibaultGROUEIX/Kernel-Methods-mva/README?pixel)](https://github.com/ThibaultGROUEIX/Kernel-Methods-mva/)