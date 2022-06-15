# Dask Presentation

Materials to support my presentation on Dask.

## Setup

1. Download the [Store Sales Time Series Forecasting data](https://www.kaggle.com/competitions/store-sales-time-series-forecasting/data) from Kaggle. Unzip and save this into the `data` directory.
2. Download the [Flights Data](https://www.kaggle.com/code/miquar/explore-flights-csv-airports-csv-airlines-csv/data?select=flights.csv) from Kaggle. Save the files into the flights sub-directory.


Your data directory should look like this:
```
- data
    - flights
    - store-sales-time-series-forecasting
```

Note - the Flights data is reproduced 20 times in the 1. Dask DataFrame notebook in order to generate meaningful comparisons with pandas. This is just enough to fit in pandas memory and also big enough for Dask to run well.

2. If you have Make installed, you can create the required Python environment by running `make create-environment`
3. If you don't have Make installed you can do this manually by running:

```bash
conda create --name dask-presentation --channel conda-forge --yes python=3.8
conda activate dask-presentation
conda install --yes --file requirements-conda.txt
ipython kernel install --user --name=dask-presentation
```
4. You should now be able to run the code in the notebooks! Enjoy =)

Useful Links:
https://docs.dask.org/en/stable/best-practices.html
https://distributed.dask.org/en/stable/memory.html
https://tutorial.dask.org/02_bag.html
https://tutorial.dask.org/04_dataframe.html
https://saturncloud.io/blog/local-cluster/
https://distributed.dask.org/en/stable/journey.html
https://tutorial.dask.org/01_dask.delayed.html
https://docs.dask.org/en/stable/scheduling.html
https://distributed.dask.org/en/stable/api.html#distributed.Client

