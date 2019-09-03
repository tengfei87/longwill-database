
--2.1
-- select
--     yk_rk01.lrrq '记账日期',
--     (select ypmc from yk_typk where ypxh = yk_rk02.ypxh) '名称',
--     yk_rk02.rksl '购入数量',
--     yk_rk02.jhhj '购入金额',
--     yk_rk02.lsje '零售金额',
--     (select ypgg from yk_typk where ypxh = yk_rk02.ypxh) '规格',
--     (select dwmc from yk_jhdw where dwxh = yk_rk01.dwxh) '供货商',
--     yk_rk01.rkdh '入库单号',
--     yk_rk02.fphm '发票号',
--     yk_rk02.ypph '生产批号',
--     '' '特殊备注'
-- from yk_rk01,yk_rk02
-- where yk_rk01.xtsb = yk_rk02.xtsb
-- and yk_rk01.rkfs = yk_rk02.rkfs
-- and yk_rk01.rkdh = yk_rk02.rkdh
-- and yk_rk01.rkrq >= '2018-07-01'
-- and yk_rk01.rkrq < '2019-07-01'
-- and yk_rk01.rkbz like '%天狐%'
-- and yk_rk01.rkpb > 0


--2.2
--2.2
--  select
--  (select ypmc from yk_typk where ypxh = a.ypxh) '名称',
--  (select ypgg from yk_typk where ypxh = a.ypxh) '规格',
-- '' '供货商',
--  sum(a.rksl) '进货数量',
--  sum(a.rkje) '进货金额',
--  sum(a.cksl) '销售数量',
--  sum(a.ckje) '销售金额'
--  from (
--  select
--  yk_rk02.ypxh ypxh,
--  '' ghdw,
--  sum(yk_rk02.rksl) rksl ,
--  sum(yk_rk02.jhhj) rkje ,
-- 0 as cksl,
-- 0 as ckje
--  from yk_rk01,yk_rk02
--  where yk_rk01.xtsb = yk_rk02.xtsb
--  and yk_rk01.rkfs = yk_rk02.rkfs
--  and yk_rk01.rkdh = yk_rk02.rkdh
--  and yk_rk01.rkrq >= '2018-07-01'
--  and yk_rk01.rkrq < '2019-07-01'
--  and yk_rk01.rkbz like '%天狐%'
--  and yk_rk01.rkpb > 0
--  group by yk_rk02.ypxh
--  union all
--  select 
--  yf_mzfymx.ypxh ypxh,
-- '' ghdw,
-- 0 as rksl,
-- 0 as rkje,
--  sum(ypsl * yf_mzfymx.yfbz / yk_typk.zxbz) cksl,
--  sum(hjje) ckje
--  from yf_mzfymx,yk_typk
--  where yfsb = 22
--  and fyrq >= '2018-07-01'
--  and fyrq < '2019-07-01'
--  and yf_mzfymx.ypxh = yk_typk.ypxh
--  group by yf_mzfymx.ypxh
--  ) a
--  group by ypxh


--3销售系统
select
b.sfrq '结算时间',
a.kfrq '处方时间',
b.brxm '姓名',
(select sfzh from ms_brda where brid = b.brid) '身份证号',
(select case brxb when 1 then '男' when 2 then '女' end from ms_brda where brid = b.brid) '性别',
(select ybkh from ms_brda where brid = b.brid) '医保卡号',
(select xzmc from gy_brxz where brxz = b.brxz) '费用类别',
a.ypmc '药品名称',
a.yfgg '规格',
a.ypsl  '数量',
b.zjje '合计金额',
b.qtys '医保支付',
b.xjje '现金支付',
'' '诊断',
(select  ygxm from gy_ygdm where ygdm = a.ysdm) '开单医生',
(select dwmc from ms_brda where brid = b.brid) '参保单位',
(select hkdz from ms_brda where brid = b.brid) '家庭地址',
(select jtdh from ms_brda where brid = b.brid) '联系电话'
from (
           select 
           (select ypmc from yk_typk where ypxh = ms_cf02.ypxh) ypmc,
           ypsl,
           ypdj,
           yfdw,
           hjje,
           (select cdmc from yk_cddz where ypcd = ms_cf02.ypcd) ypcd,
           yfgg,
           ysdm,
           mzxh,
           kfrq
           from ms_cf01,ms_cf02
           where ms_cf01.cfsb = ms_cf02.cfsb
           and ms_cf01.mzxh > 0
           union all
           select 
           (select fymc from gy_ylsf where fyxh = ms_yj02.ylxh) ypmc,
           ylsl,
           yldj,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfdw,
           hjje,
           '' ypcd,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfgg,
           ysdm,
           mzxh,
           kdrq kfrq
           from ms_yj01,ms_yj02
           where ms_yj01.yjxh = ms_yj02.yjxh
           and ms_yj01.mzxh > 0) a,ms_mzxx b
where a.mzxh = b.mzxh
and b.sfrq >= '2018-07-01'
and b.sfrq < '2019-07-01'
and b.mzlb = 4
and b.zfpb= 0
order by b.mzxh

select
b.sfrq '结算时间',
a.kfrq '处方时间',
b.brxm '姓名',
(select sfzh from ms_brda where brid = b.brid) '身份证号',
(select case brxb when 1 then '男' when 2 then '女' end from ms_brda where brid = b.brid) '性别',
(select ybkh from ms_brda where brid = b.brid) '医保卡号',
(select xzmc from gy_brxz where brxz = b.brxz) '费用类别',
a.ypmc '药品名称',
a.yfgg '规格',
-1 * a.ypsl  '数量',
-1 * b.zjje '合计金额',
-1 * b.qtys '医保支付',
-1 * b.xjje '现金支付',
'' '诊断',
(select  ygxm from gy_ygdm where ygdm = a.ysdm) '开单医生',
(select dwmc from ms_brda where brid = b.brid) '参保单位',
(select hkdz from ms_brda where brid = b.brid) '家庭地址',
(select jtdh from ms_brda where brid = b.brid) '联系电话'
from (
           select 
           (select ypmc from yk_typk where ypxh = ms_cf02.ypxh) ypmc,
           -1 *ypsl,
           ypdj,
           yfdw,
           -1 *hjje,
           (select cdmc from yk_cddz where ypcd = ms_cf02.ypcd) ypcd,
           yfgg,
           ysdm,
           mzxh,
           kfrq
           from ms_cf01,ms_cf02
           where ms_cf01.cfsb = ms_cf02.cfsb
           and ms_cf01.mzxh > 0
           union all
           select 
           (select fymc from gy_ylsf where fyxh = ms_yj02.ylxh) ypmc,
           -1 * ylsl,
           yldj,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfdw,
          -1 * hjje,
           '' ypcd,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfgg,
           ysdm,
           mzxh,
           kdrq kfrq
           from ms_yj01,ms_yj02
           where ms_yj01.yjxh = ms_yj02.yjxh
           and ms_yj01.mzxh > 0) a,ms_mzxx b
where a.mzxh = b.mzxh
and exists (select 1 from ms_zffp where mzxh = b.mzxh and zfrq >= '2018-07-01'  and zfrq < '2019-07-01')
and b.mzlb = 4

order by b.mzxh


--select top 1 convert(date,sfrq),sum(zjje)
--from MS_MZXX
--where sfrq >= '2018-07-01'
--and sfrq < '2019-07-01'
--and mzlb = 4
--and brxz = 170
--group by convert(date,sfrq)
--order by sum(zjje) desc





select
b.sfrq '结算时间',
a.kfrq '处方时间',
b.brxm '姓名',
(select sfzh from ms_brda where brid = b.brid) '身份证号',
(select case brxb when 1 then '男' when 2 then '女' end from ms_brda where brid = b.brid) '性别',
(select ybkh from ms_brda where brid = b.brid) '医保卡号',
(select xzmc from gy_brxz where brxz = b.brxz) '费用类别',
b.fphm,
a.ypmc '药品名称',
a.yfgg '规格',
a.ypsl  '数量',
b.zjje '合计金额',
b.qtys '医保支付',
b.xjje '现金支付',
'' '诊断',
(select  ygxm from gy_ygdm where ygdm = a.ysdm) '开单医生',
(select dwmc from ms_brda where brid = b.brid) '参保单位',
(select hkdz from ms_brda where brid = b.brid) '家庭地址',
(select jtdh from ms_brda where brid = b.brid) '联系电话'
from (
           select 
           (select ypmc from yk_typk where ypxh = ms_cf02.ypxh) ypmc,
           ypsl,
           ypdj,
           yfdw,
           hjje,
           (select cdmc from yk_cddz where ypcd = ms_cf02.ypcd) ypcd,
           yfgg,
           ysdm,
           mzxh,
           kfrq
           from ms_cf01,ms_cf02
           where ms_cf01.cfsb = ms_cf02.cfsb
           and ms_cf01.mzxh > 0
           union all
           select 
           (select fymc from gy_ylsf where fyxh = ms_yj02.ylxh) ypmc,
           ylsl,
           yldj,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfdw,
           hjje,
           '' ypcd,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfgg,
           ysdm,
           mzxh,
           kdrq kfrq
           from ms_yj01,ms_yj02
           where ms_yj01.yjxh = ms_yj02.yjxh
           and ms_yj01.mzxh > 0) a,ms_mzxx b
where a.mzxh = b.mzxh
and b.sfrq >= '${kssj}'
and b.sfrq < dateadd(d,1,'${jssj}')
and b.mzlb = ${mzlb}
union all
select
b.sfrq '结算时间',
a.kfrq '处方时间',
b.brxm '姓名',
(select sfzh from ms_brda where brid = b.brid) '身份证号',
(select case brxb when 1 then '男' when 2 then '女' end from ms_brda where brid = b.brid) '性别',
(select ybkh from ms_brda where brid = b.brid) '医保卡号',
(select xzmc from gy_brxz where brxz = b.brxz) '费用类别',
b.fphm,
a.ypmc '药品名称',
a.yfgg '规格',
-1 * a.ypsl  '数量',
-1 * b.zjje '合计金额',
-1 * b.qtys '医保支付',
-1 * b.xjje '现金支付',
'' '诊断',
(select  ygxm from gy_ygdm where ygdm = a.ysdm) '开单医生',
(select dwmc from ms_brda where brid = b.brid) '参保单位',
(select hkdz from ms_brda where brid = b.brid) '家庭地址',
(select jtdh from ms_brda where brid = b.brid) '联系电话'
from (
           select 
           (select ypmc from yk_typk where ypxh = ms_cf02.ypxh) ypmc,
           ypsl,
           ypdj,
           yfdw,
           hjje,
           (select cdmc from yk_cddz where ypcd = ms_cf02.ypcd) ypcd,
           yfgg,
           ysdm,
           mzxh,
           kfrq
           from ms_cf01,ms_cf02
           where ms_cf01.cfsb = ms_cf02.cfsb
           and ms_cf01.mzxh > 0
           union all
           select 
           (select fymc from gy_ylsf where fyxh = ms_yj02.ylxh) ypmc,
           ylsl,
           yldj,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfdw,
           hjje,
           '' ypcd,
           (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfgg,
           ysdm,
           mzxh,
           kdrq kfrq
           from ms_yj01,ms_yj02
           where ms_yj01.yjxh = ms_yj02.yjxh
           and ms_yj01.mzxh > 0) a,ms_mzxx b
where a.mzxh = b.mzxh
and exists (selelct 1 from ms_zffp where mzxh = b.mzxh and zfrq >= '${kssj}' and zfrq < '${kssj}')
and b.mzlb = ${mzlb}



