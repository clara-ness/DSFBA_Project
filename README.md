# European countries, their dietary habits and diabetes prevalence
<p align="center">
     <img src="https://github.com/clara-ness/DSFBA_Project/blob/24bd6f3183e33ae8ae537c8517ca88e1937b0879/diab.png"/>
  <br />
    Welcome to our report !
    <br />
    <a href="https://rpubs.com/clara-ness/DSFBA_Project"><strong>Read the report »</strong></a>
    <br />
    <br />
    <a href="https://github.com/clara-ness/DSFBA_Project/issues">Report Bug</a>
    ·
    <a href="https://github.com/clara-ness/DSFBA_Project/issues">Request Feature</a>

  </p>
</p>
<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Report</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#visualisation ">Visualisation </a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

<!-- ABOUT THE REPORT -->
## About The Report

During the last 2 years, COVID-19 has been a main focus of the news. Though around 3% of the world population had COVID-19, diabetes can be considered as an even bigger health problem. Indeed, according to the International Diabetes Foundations (IDF), in 2019, 463 million adults were living with diabetes (around 6-7% of the world population) and this number is forecasted to rise to 700 million by 2050. Furthermore, 90% of cases of diabetes are of type 2, which means it results mainly from bad habits and not genetics. However both types of diabetes can be treated and/or prevented with a healthier diet and more physical activity. Additionally, according to the WHO, low income countries are more susceptible to having higher diabetes prevalence. Living in Europe, we observed that diabetes rates differ from one country to another, so we wanted to find out if these rates were indeed linked to a country’s income, and if the nutritious composition of richer states’ population’s diet is also affected by this income difference and if yes, how it is affected. 

## Built With
The report has been created through different packages. 

For the project's organization:
* [Here](https://www.rdocumentation.org/packages/here/versions/1.0.1/topics/here)

For wrangling:
* [Tidyverse](https://www.tidyverse.org/) that includes the following packages:
  * [ggplot2](https://ggplot2.tidyverse.org/)
  * [dplyr](https://dplyr.tidyverse.org/) 
  * [tidyr](https://tidyr.tidyverse.org/) 
  * [readr](https://readr.tidyverse.org/) 
  * [lubridate](https://lubridate.tidyverse.org/) 
  * [readyl](https://readxl.tidyverse.org/) 
* [data.table](https://rstudio.github.io/DT/)

For plotting: 
* [ggrepel](https://github.com/slowkow/ggrepel)
* [gghighlight](https://cran.r-project.org/web/packages/gghighlight/vignettes/gghighlight.html)
* [patchwork](https://cran.r-project.org/web/packages/patchwork/index.html)
* [maps](https://cran.r-project.org/web/packages/maps/index.html)
* [scales](https://scales.r-lib.org/)
* [plotly](https://plotly.com/)
* [papeR](https://cran.r-project.org/web/packages/papeR/vignettes/papeR_introduction.html)
* [ggpubr](https://cran.r-project.org/web/packages/ggpubr/index.html)

For mapping: 
* [Leaflet](https://rstudio.github.io/leaflet/)
* [eurostat](https://cran.r-project.org/web/packages/eurostat/index.html)
* [sf](https://cran.r-project.org/web/packages/sf/index.html)
* [geojsonsf](https://cran.r-project.org/web/packages/geojsonR/vignettes/the_geojsonR_package.html)

For the report: 
* [knitr](https://cran.r-project.org/web/packages/knitr/index.html)
* [kableExtra](https://cran.r-project.org/web/packages/kableExtra/index.html)
* [bookdown](https://bookdown.org/)
* [rmardown](https://rmarkdown.rstudio.com/)
* [parameters](https://rmarkdown.rstudio.com/lesson-6.html)
* [see](https://cran.r-project.org/web/packages/see/index.html)
* [factoextra](https://cran.r-project.org/web/packages/factoextra/index.html)
* [NbClust](https://www.rdocumentation.org/packages/NbClust/versions/3.0/topics/NbClust)
* [sjPlot](https://cran.r-project.org/web/packages/sjPlot/index.html)
* [sjmisc](https://cran.r-project.org/web/packages/sjmisc/index.html)
* [sjlabelled](https://cran.r-project.org/web/packages/sjlabelled/index.html)
                                   
<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

The project can either be run locally or find online going to this [website](https://rpubs.com/clara-ness/DSFBA_Project).

### Installation

1. Install R-Studio on your computer
2. Clone the repo
   ```sh
   git clone https://github.com/clara-ness/DSFBA_Project.git
   ```
3. Open the repo
4. Go to the report files and knit the report.Rmd
                                   
<!-- VISUALISATION -->
## Visualisation

The project consists of three folders: 

1) The [scripts](scripts/setup.R) folder with the file [setup.R] where all the packages are installed and load.

2) The [data](data/) folder where all our data is stored.

3) The [Slides&video](Slides&video/) where our slides and the video presentation are stored.
                                   
4) The [report](report/) folder, which contains all the parts of our report each stored in a different markdown files.
                                  
                                   
When you arrive on the report, you only need to knit the [report.Rmd] in order to have all the report. All the folders and files are linked thanks to our package [Here](https://www.rdocumentation.org/packages/here/versions/1.0.1/topics/here).
<!-- DATA USED -->
## Data Used

The following websites were used to export data: 
1. [Our World in Data (kcal)](https://ourworldindata.org/diet-compositions)
2. [World Bank (GDP)](https://data.worldbank.org/indicator/NY.GDP.MKTP.CD?end=2020&locations=EU&start=1966&view=chart)
4. [World Bank (population)](https://data.worldbank.org/indicator/SP.POP.TOTL)
3. [NCD Risk Factor Collaboration (diabetes)](https://www.ncdrisc.org/data-downloads-diabetes.html)

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT License. See [LICENSE](LICENSE.md/) for more information.

<!-- CONTACT -->
## Contact
                                   
If you have any question feel free to contact us in writing an issue in this repository. 

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
*  Professor Thibault Vatter as well as Teaching Assistants Emma Maury, Luca Giacobi and Daniel Szenes for their knowledge shared with us.  
*  The team: Alesya Alpbaz, Clara Nessi and Fabien Calderini                   
