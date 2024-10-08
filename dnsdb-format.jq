#!/usr/bin/jq -rf

select(
    (.time_first | strftime("%Y")) == "2024" or 
    (.time_last | strftime("%Y")) == "2024"
  ) |
  .time_first |= ( . | strftime("%Y-%m-%d %H:%M:%S")) |
  .time_last |= ( . | strftime("%Y-%m-%d %H:%M:%S"))
