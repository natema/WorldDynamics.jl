# WorldDynamics.jl

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://worlddynamics.github.io/WorldDynamics.jl/stable/)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://worlddynamics.github.io/WorldDynamics.jl/dev/)
[![DOI](https://zenodo.org/badge/425565525.svg)](https://zenodo.org/badge/latestdoi/425565525)

WorldDynamics.jl is an open-source framework written in Julia for world dynamics modeling and simulation. 
Check out the [WorldDyanmics Organization](https://github.com/worlddynamics) for information on the World Dynamics project. 

### Getting started

From the Julia REPL, install the package with 
```jl
]add WorldDynamics
```
You can now use the package, e.g. for reproducing Figure 7.7 from the book [_Dynamics of growth in a finite world_](https://archive.org/details/dynamicsofgrowth0000unse): 
```jl
using WorldDynamics
World3.fig_7()
```
Here is the output superposed to the original picture: 
![image](https://user-images.githubusercontent.com/2920162/194111344-8682a97f-f4de-4e2d-ba7e-980546e1bfaf.png)

For how to produce different figures (and much more), please see [the documentation](https://worlddynamics.github.io/WorldDynamics.jl/stable/).

### How to cite this work 

```
@software{pierluigi_crescenzi_2022_7093581,
  author       = {Pierluigi Crescenzi and
                  Emanuele Natale and
                  Paulo Bruno Serafim},
  title        = {WorldDynamics.jl: v0.1.0},
  month        = sep,
  year         = 2022,
  publisher    = {Zenodo},
  version      = {v0.1.0},
  doi          = {10.5281/zenodo.7093581},
  url          = {https://doi.org/10.5281/zenodo.7093581}
}
```

### Acknowledgments 

We thank for their support: 

|   |   |   |
|---|---|---|
| [<img src="docs/src/assets/logo-i3s.png" width="200" />](https://www.i3s.unice.fr/fr) | [<img src="docs/src/assets/logo-ds4h.png" width="120" />](https://ds4h.univ-cotedazur.eu/about-us/rise) | [<img src="docs/src/assets/logo-idex-ucajedi.png" width="200" />](https://univ-cotedazur.fr/universite/ucajedi-lidex-duniversite-cote-dazur) | 
| [<img src="docs/src/assets/logo-inria.png" width="200" />](https://www.inria.fr/fr) | [<img src="docs/src/assets/logo-cnrs.png" width="100" />](https://www.cnrs.fr/) | [<img src="docs/src/assets/logo-UniversitadiRomaTorVergata.png" width="120" />](https://ing.uniroma2.it) |
|   | [<img src="docs/src/assets/logo-gssi.png" width="210" />](https://www.gssi.it/) | |
