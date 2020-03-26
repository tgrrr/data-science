| Feature Name            | Feature Type         | Data Type | Description                                                                                            | Transform ~old_todo~                                                                                                                                                                                  | DataVis Convert ?                                                                                                                                                                                                                               |
| ----------------------- | -------------------- | --------- | ------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **company_id**          | nominal categorical  | int64     | Company ID of record                                                                                   | oneHotEncode()                                                                                                                                                                                  |                                                                                                                                                                                                                                                 |
| **country_id**          | nominal categorical  | int64     | Country ID of record _iso3166 1.0_                                                                     | oneHotEncode()?binary/scaling it                                                                                                                                                                | _iso3166 1.0_ to # country                                                                                                                                                                                                                      |
| **device_type**         | nominal categorical  | int64     | Device type of record                                                                                  | oneHotEncode()                                                                                                                                                                                  | ~old_fixme~1 Desktop, 2 mobile, 3 tablet, 5 # ConnectedTv                                                                                                                                                                                            |
| * **day**               | ordinal integer*     | int64     | Day of record <br/> - between 1 (oldest) and 30 for train, <br/> - between 31 (oldest) and 35 for test | - Integer-encoding <br />~old_todo~ add a global variable for whether it's training/test                                                                                                             |                                                                                                                                                                                                                                                 |
| * **dow**               | ordinal categorical* | object    | Day of week of the record                                                                              | ??? <br /> dow_friday <br /> dow_monday <br />  dow_saturday <br />   dow_sunday <br />   dow_thursday <br /> dow_tuesday <br />  dow_wednesday <br /> - maybe: split into weekday and weekend? | Note: normally we would have [transformed `dow` data as time series](https://datascience.stackexchange.com/questions/17759/# encoding-features-like-month-and-hour-as-categorial-or-numeric). However, the assignment specifies not to do this. |
| **price1,...,3**        | numeric              | float64   | Price combination for the record set by the company                                                    |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **ad_area**             | numeric              | float64   | area of advertisement (normalized between 0 and 1)                                                     |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **ad_ratio**            | numeric              | float64   | ratio of advertisement's length to its width (normalized between 0 and 1)                              |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **requests**            | numeric              | int64     | ~old_todo~                                                                                                  |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **impression**          | numeric              | float64   | ~old_todo~                                                                                                  |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **cpc**                 | numeric              | float64   | float64                                                                                                | ~old_todo~                                                                                                                                                                                           |                                                                                                                                                                                                                                                 |
| **ctr**                 | numeric              | float64   | ~old_todo~                                                                                                  |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **viewability**         | numeric              | float64   | ~old_todo~                                                                                                  |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **ratio1, ..., ratio5** | numeric              | float64   | Ratio characteristics related to the record (normalized between 0 and 1)                               |                                                                                                                                                                                                 |                                                                                                                                                                                                                                                 |
| **y (target feature)**  | numeric              | float64   | revenue-related metric                                                                                 | - split into separate dataset <br /> - don't normalise                                                                                                                                          |                                                                                                                                                                                                                                                 |