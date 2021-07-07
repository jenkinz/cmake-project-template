# Code Review Approval Checklist

/assign_reviewer @user1 @user2
/assign @user
/label code-review

## Description of Changes

(Summarize the change concisely)

## Related Issues

- Contributes to #1 (change this to relevant issue number(s))
- Closes #2 (change this to relevant issue number(s))

## MR Attributes

* [ ] MR assigned to correct person for review and approval (see `CODEOWNERS`
      file in project)
* [ ] Label set as `Code Review`
* [ ] Source branch contains changes to-be-merged, target branch is `main`

## Code Conformity

**Code Review Checklist**

* [ ] File header present and correct (Sandel copyright and date)
* [ ] File Doxygen header present (`@name`, `@ingroup`, `@note Reviewed` (see
next item))
* [ ] `@note Reviewed MM/dd/YYYY - Description` present in file Doxygen header corresponding to this review
* [ ] Header files only: must have include guard (`#ifdef XXX_H`)
* [ ] All function/method definitions and classes have a Doxygen comment block
* [ ] No build warnings or errors
* [ ] No `#if 0`
* [ ] No debug log statements or printf/fprintf etc. (info, notice, warn, err,
and fatal console logs are permitted)
* [ ] Comments are accurate
* [ ] Code has been formatted properly with the automatic Sandel Profile
formatter
* [ ] Code is in compliance with Sandel Software Code Standard
* [ ] Quality metrics (static analysis) show no issues (or exceptions
dispositioned) for each source file changed by this MR
* [ ] Cyclomatic complexity of each function is <= 10 for each source file
changed by this MR
* [ ] Pipeline passed (all jobs - MR cannot be merged without a passing
pipeline)
