# Oracle Explain Plan

## Overview

- An explain plan is a representation of the access path that is taken when a query is executed within Oracle.
- The explain plan is produced by the optimizer. once the access path has been decided upon it is stored in the library cache memory structure together with the statement itself.  (reused)

## Order

建成一棵树，后序遍历即为执行次序

![image-20211222155041433](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202112221550608.png)

## Interpret

### FULL Table Scans

The entire table is read up to the high water mark(HWM). 

The HWM marks the last block in the table that has ever had data written to it. 

If you have deleted all the rows in a table you will still read up to the HWM.

PS：HWM 太高的话会影响读取时间

### Join Methods, Join Order

#### Nested Loop

- First we return all the rows from row source 1(Driving Table), typically the smaller of the two row sources.

- Then we probe row source 2 (Inner Table)once for each row returned from row source 1.

  

- Good for joining **smaller row sources**.

- Best used with **indexed foreign key columns**.

#### Hash Join

- Smallest row source is chosen and used to build A hash table (in memory) and a bitmap.

- The second row source is hashed and checked against the hash table looking for joins. The bitmap is used as a quick lookup to check if rows are in the hash table.

  

- Good for joining **larger row sources**.

- Needs PGA memory.

- If PGA is not enough, Optimizer will choose nested loop.

#### Sort Merge Join

if you have any volume of data that's going to be quite large, he'd have to do those in the PGA as well, and in this case he may consider a hash join. if there's not enough room in the PGA and he may decide to do a nested loop where there's an index there or not on the foreign key column then he have no choice but the sort merge join  and do it on the disk when PGA memory is not big enough. **slower**

- Rows are produced by row source 1 and are then sorted.
- Rows from row source 2 are then produced and sorted by the same sort key as Row Source 1.
- Row source 1 and 2 are NOT accessed concurrently.
  Sorted rows from both sides are then merged
  together.
- Needs PGA Memory.

#### Cartesian Join

**(should be avoided)**

- Every row from one row source is joined to every
  row from the second row source.
- Usually the result of a poorly written join.

### Index Access Methods

#### Index Range Scan

- Method for accessing multiple column values.
- read at least one block (at the leaf level) **which closely to the match most** at a time
- A non-unique index may return multiple values for the predicate col1 = n and will use an index range scan.

#### Index Unique Scan

- Method for looking up a single key value via a unique index. Always returns a single value.
- doesn't have to scan multiple blocks especially at the leaf level so when he finds his match at the leaf level he knows he's done, doesn't have to scan other blocks

#### Index Full Scan

- In certain circumstances it is possible for the whole index to be scanned where **no constraining predicates** are provided for a table.
- An index full scan will perform single block i/o's and SO 1t may prove to be inefficient.

#### Index Fast Full Scan

- Scans all the block in the index Rows **are not returned In sorted order**.
- Uses multiblock i/o and can be executed in **parallel**.

#### Index Skip Scan

- The optimizer can perform skip scans to retrieve rowids for values that do not use the prefix of a concatenated index.
- Initiated by probing the index for distinct values of the prefix column. Each of these distinct values is then used as a starting point for a regular index search.

## References

[Interpreting Oracle Explain Plan Output - John Mullins](https://www.youtube.com/watch?v=AhKgGRM_piY)

![image-20211222221556017](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202112222215113.png)