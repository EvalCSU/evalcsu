# Oracle Architecture

![image-20211220220715591](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202112202207668.png)

We First learn single instance below.

**Consist of Instance and Database**

Instance consists of **Memory Structures** and **Background Process**

Database consists consists of **Files**(Control Files, Redo Log files, Data Files...)

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080029332.jpg)

## Instance

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080029399.jpg)

Memory

- SGA (System Global Area): shared memory; 大家都可以访问
- PGA (Process Global Area): private memory; 只有特定进程可以访问

Background Process

- Client Process: runs Application or Oracle Tool code
- Oracle Process: runs Oracle Database Code
  - Server Processes/Foreground Processes: handles all the requests from the clients; eg: parsing and running SQL statements, and retrieving and returning results to the client programs.
  - Background Processes: complete tasks; Oracle Database creates background processes automatically when a database instance starts

### 1. SGA

SGA is configurable.

All Server processes and Background share the SGA.

- caches data
- meta data
- execution plans
- maintain internal data structures

Components

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080030157.jpg)

（实线代表必须，虚线代表可有可无）

- Data Buffer Cache

  - stores copies of data blocks read from data files.
  - All users concurrently connected to a database instance share access to the buffer cache.

- Redo Log Buffer

  - description of changes made to the database

- Shared Pool

  - caches various types of program data like parsed SQL, PL/SQL code, system parameters and data dictionary information.

- Fixed SGA

  an internal housekeeping area that contains

  - General information about the state of the database and instance
  - information communicated between processes, such as information about locks

### 2. PGA

- Session
- Bind Variable values
- Parsed SQL statements
- Query execution state: how many rows are fetched...

Components

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080030760.jpg)

- SQL Work Area
- Session Memory
- Private SQL Area: how many rows are fetched...

### 3. Background

- perform maintenance tasks required to operate the database
- Each background process performs a unique task, but works with the other processes
- Oracle Database creates background processes automatically when you start a database instance

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080030102.jpg)

（实线代表必须，虚线代表可有可无）

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080030578.jpg)

Server Process is started with the connection and stopped with the connection whereas the Background Process is ... instance

## Database

Database consists of Files

To store and manage data, Oracle Database uses

- PSS (Physical Storage Structures): include Data files, Control files, Redo Log files; viewable at the OS level;
- LSS (Logical Storage Structures): Data Blocks, Extents, Segments and Tablespaces

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080030804.jpg)

one tablespace is like

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202112221536173.jpg)

![](https://raw.githubusercontent.com/Yemonade/imgCloud/main/img/202202080030949.jpg)

## 关闭

ABORT

Proceeds with the **fastest** possible shutdown of the database **without waiting for calls to complete or users to disconnect.**

**Uncommitted transactions are not rolled back**. Client SQL statements **currently being processed are** **terminated**. All users currently connected to the database are implicitly disconnected and **the next database startup will require instance recovery**.

You must use this option if a background process terminates abnormally.

IMMEDIATE

**Does not wait for current calls to complete or users to disconnect from the database.**

Further connects are prohibited. **The database is closed and dismounted**. The instance is shutdown and **no instance recovery is required on the next database startup**.

NORMAL

NORMAL is the default option which **waits for users to disconnect from the database**.

Further connects are prohibited. The database is closed and dismounted. The instance is shutdown and **no instance recovery is required on the next database startup**.

TRANSACTIONAL [LOCAL]

Performs a planned shutdown of an instance while allowing active transactions to complete first. It prevents clients from losing work without requiring all users to log off.

**No client can start a new transaction on this instance.** Attempting to start a new transaction results in disconnection. **After completion of all transactions, any client still connected to the instance is disconnected**. Now the instance shuts down just as it would if a SHUTDOWN IMMEDIATE statement was submitted. **The next startup of the database will not require any instance recovery procedures.**



## 表空间



## 1. 创建表空间

```plsql
create tablespace ts_xxx
[datafile 'path/fname.dbf' size 50k reuse,
			'path/fname.dbf' size 50m reuse]
			
[autoextend on next 50m] | [autoextend off]

[maxsize [unlimited | 20m]]
[mininum extent 20m]
[default storage ???]
[online | offline]
[logging | nologging]
[permanent | temporary]

extent management dictionary 
| 
extent management local [autoallocate | uniform size 50m]
```

## 2. 维护表空间

```plsql
-- 设置默认永久表空间
alter database default tablespace ts_xxx;
-- 设置默认临时表空间
alter database default temporary tablespace ts_xxx;

-- 更改表空间状态
alter tablespace ts_xxx read only;
alter tablespace ts_xxx read write;

-- 改变数据文件容量
alter database datafile 'path/fname.dbf' resize 50M;
-- 增加数据文件
alter tablespace ts_xxx add datafile 'path/fname.dbf' size 200M;

-- 改变表空间容量
alter tablespace ts_xxx
add datafile 'path/fname.dbf' size 10m ...
-- 修改表空间为脱机状态
alter tablespace ts_xxx offline;

-- 重命名表空间
alter tablespace ts_xxx rename to ts_yyy;
-- 重命名数据文件
alter database rename file 'path/fname.dbf' to '...'

-- 删除表空间
drop tablespace ts_xxx [inclufing contents] [cascade constraints] -- [也删除数据][也删除完整性限制]
```

