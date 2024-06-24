sheet <- list()
library(googlesheets4)
library(tidyverse)
# import weekly grades
read_sheet("https://docs.google.com/spreadsheets/d/1FjnhP4b34njhTlqAdLVbY_tSmUtv28iMj1E8js8zutQ/edit#gid=821359660",
           sheet="Sheet4") -> sheet$weekly_grades
sheet$weekly_grades |>
  glimpse()

sheet$weekly_grades |>
  rename("評分項目"="作品") |>
  filter(評分項目=="得分") |>
  pivot_longer(cols = -c(評分項目,week), names_to = "作品", values_to = "得分") |>
  mutate(
    作品=as.numeric(作品)
  ) |>
  select(-評分項目) ->
  sheet$weekly_grades_long

sheet$weekly_grades_long |>
  glimpse()

# import submission form
read_sheet("https://docs.google.com/spreadsheets/d/1FjnhP4b34njhTlqAdLVbY_tSmUtv28iMj1E8js8zutQ/edit#gid=821359660",
           sheet="Form Responses 1") -> sheet$submission_form

sheet$submission_form |>
  glimpse()
  
# 創造week column為"週次"column中的值"112-2-weekXX" 的 "XX"字串，以數字型態儲存
sheet$submission_form |>
  mutate(week = as.numeric(str_extract(週次, "\\d+$"))) ->
  sheet$submission_form

sheet$submission_form |>
  glimpse()

# merge weekly_grades_long to submission_form
sheet$submission_form |>
  right_join(sheet$weekly_grades_long, by=c("week","作品")) ->
  sheet$submission_form_with_grade

sheet$submission_form_with_grade |>
  select(
    姓名, week, 得分
  ) -> sheet$submission_form_with_grade_long

sheet$submission_form_with_grade_long |>
  glimpse()

compute_grade <- function(grades){
  grades |>
    na.omit() -> grades
  if(length(grades)==5){
    return(
      (sum(grades)-min(grades))/4
    )
  } else {
    return(sum(grades)/4)
  }
}

sheet$submission_form_with_grade_long |>
  group_by(姓名) |> 
  summarise(
    平均得分= compute_grade(得分)
  ) -> sheet$weekly_grade_average

sheet$submission_form_with_grade |>
  select(
    姓名, week, 得分
  ) |> na.omit() |>
  pivot_wider(
    names_from = "week",
    values_from = "得分"
  ) -> sheet$submission_form_with_grade_wide

sheet$weekly_grade_average |>
  right_join(
    sheet$submission_form_with_grade_wide,
    by=c("姓名"="姓名")
  ) -> sheet$submission_form_with_grade_wide_avg

sheet$submission_form_with_grade_wide_avg |> 
  glimpse()

# semester-grade
read_sheet("https://docs.google.com/spreadsheets/d/1RbBnrgnDNJNFtxs8LKEGlYp2AFk4DvjCHbwDFDr1G5c/edit#gid=76023874",
           sheet="semester-grade") -> sheet$semester_grade

sheet$semester_grade |>
  left_join(sheet$submission_form_with_grade_wide_avg, by=c("選單"="姓名")) ->
  sheet$semester_grade_finalized

write_sheet(
  sheet$semester_grade_finalized,
  "https://docs.google.com/spreadsheets/d/1RbBnrgnDNJNFtxs8LKEGlYp2AFk4DvjCHbwDFDr1G5c/edit#gid=76023874",
            sheet="semester-grade-finalized")
