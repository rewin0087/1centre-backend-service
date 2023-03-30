# Coding exercise - Application Report Trend

## Specifications

The task is to read a JSON file containing applications with their timestamps and omni-channels (sales, website, or qr). Provide a method that returns the average number (rounded up) of applications by hour (0 to 23) of the day across the total number of days available. The method also accepts a channel parameter (`all`, `sales`, `website`, and `qr`) to filter the results based on which channel the application came from. An `all` value returns all the applications regardless of channel.

A skeleton code (Ruby) and test (RSpec) has been provided to get you started. Write the necessary code to achieve the requirements and write tests for your solution.

## Data

A JSON data has been provided to get you started: `applications.json`. The fields are:

1. `id`: The ID of the application in UUID format.
2. `timestamp`: The time the application has been created which will be the basis of the report. This is in NZST timezone (+12).
3. `channel`: The omni-channel where the application came from. Valid values are `sales`, `website`, and `qr`.

The JSON file contains three days worth of data which will determine how you calculate for the average. The solution should not be restricted to three days as the data source can be dynamic, it should be able to adapt if there are more days added.

## Overview

`ApplicationReport` fetch data from json file from root directory of the app and filter first records with channel if provided with existing channel.
If filter with `All` it will return all records and perform next action. Parsed timestamp field as well to time object so it will be easy to manipulate on the later part of the process. Grouped the records with hour as well based from the timestamp field so we can separate records by hours and evaluate the records accordingly. After grouping based from hour it will compute the average of the grouped records base from the range of dates from those grouped records and sort the result based from hour to return.


## Run test

Run from the root directory in the commandline

```
=> bundle exec rspec spec
```

## Run linter

Run from the root directory in the commandline

```
=> bundle exec rubocop
```


## Run on console the app

Run from the root directory in the commandline

```
=> irb
=> require_relative './app/application_report.rb'
=> ApplicationReport.new('applications.json').retrieve_trend('all')
```

## Caveat

- The results were dependent from the json file and it should provide a correct format of data to perform correct parsing and to run the process accordingly.
- The performance of the code will based on how big the data, currently the code were written in the best approach as possible which is easy to understand and maintain.
- Code is flexible since all logics were separated by methods and it utilize enums to iterate and evualate the records / array
- Later on we can extract the logic with single responsibility principle to elaborate more the process and to be able wrtie a test depending on the purpose where in we can build factory class to aggregate all the process flow we need to result the expected output.
- For improvements we can host the data from json file into a database so we can speed up the runtime since all the logic will be overhead by the database which is faster than on programming level. Database level is more reliable and efficient.

## Suggestions

- Make it simple and straightforward.
- Assume that the format of the JSON file provided is always correct. Do not think of the edge cases.
- Use of code linter is recommended. We will be looking at how you write and structure the solution.
- Remove unnecessary code or debuggers before submitting.

## Deliverable

- Provide the public git repository URL (e.g. GitHub), or a zip archive.
- The RSpec examples should be able to cover different scenarios, e.g. filters
- Update this README file containing the following:
  - Instructions how to run the specs
  - A technical overview of the implementation:
    - Summary or justification of the approach
    - Technical debts and/or areas to improve further if any
