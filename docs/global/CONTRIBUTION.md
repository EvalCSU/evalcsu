## 为EvalCSU贡献
## Contribute to EvalCSU
### [简体中文](CONTRIBUTION_zh_simplify.md) [繁體中文](CONTRIBUTION_zh_tradition.md)

All kinds of contributions are welcome, including but not limited to the following:

- Correct the spelling of any documents or bugs and typos of any project
- Add any class or test notes and mind maps, or translate existing content into other languages
- Add your curriculum  experiment project, it is best to include the report
- Add your evaluation of curriculum  experiment, courses, and teachers
   
### Workflow
**Evaluation**
1. Apply to become an evaluation participant
   1. Go to the Issue page, then click the New Issue button
   2. Select ***Apply for evaluation*** template to create your issue
   3. Assign who is responsible for the major, and send an email to notify him. then he will agree in issue if you are accepted
2. Create your pull request
   1. Please provide your evaluation through a pull request. The guide is [right below](#26-)
   2. Remember to **link the issue** that proves your quality of participant.

**Provide curriculum experiment project and report**
 
1. Create a pull request， choose all of the collaborators as reviewers， then assign who is responsible for the relating major.

**How to create a pull request**

1. fork and pull the latest version of this repo
2. create a new branch to commit your changes(don't commit to master/main branch)
3. commit your changes
4. to the pull requests page, click the "new pull request"
5. Select the master/main branch and the branch you have changed for comparing， then describe your work as right below
   1. The title format is ``` type: --timeStamp description```
   2. write a summary of your work in the context
   3. write what you have done in detail right below a "Done" title
   4. [here is the example](https://github.com/Jacob953/evalcsu/pull/3)
6. Click "Create pull request"

Please describe your issue or PR as clear as possible. And use ``NULL`` to fill blocks you don't know what to say instead of deleting them.

### WANT TO KNOW WHAT IS "PULL REQUEST" AND "ISSUE"
please refer to [noob guide](NOOBGUIDE.md)

### EvalCSU commit message

Please follow the commit formate:

```
<type>[optional scope]: <descroption>
```

**type of commit**

  <table margin="center">
    <thead>
        <tr>
            <th>type</th>
          	<th>Describtion</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>feat</td>
            <td>add a new feature</td>
        </tr>
      	<tr>
            <td>fix</td>
            <td>fix bugs</td>
     		</tr>
     	 	<tr>
            <td>docs</td>
            <td>update documents</td>
      	</tr>
      	<tr>
            <td>test</td>
            <td>add or update tests</td>
      	</tr>
      	<tr>
            <td>style</td>
            <td>format style of codes</td>
      	</tr>
      	<tr>
            <td>chore</td>
            <td>other commits</td>
      	</tr>
    </tbody>
  </table>
</div>

