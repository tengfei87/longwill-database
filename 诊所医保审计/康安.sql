-- --//1,收费信息查询，
-- select
-- ms_brda.mzhm '门诊号',
-- ms_brda.brxm  '姓名',
-- (case ms_brda.brxb when 1 then '男' when 2 then '女' end)  '性别',
-- datediff(yy,ms_brda.csny,getdate())  '年龄',
-- ms_brda.sfzh  '身份证号',
-- (select xzmc from gy_brxz where brxz = ms_mzxx.brxz) '费用类别',
-- ms_brda.ybkh  '医保卡号',
-- ms_mzxx.sfrq '收费日期',
-- ms_mzxx.fphm '发票号码',
-- ms_mzxx.zjje '费用合计',
-- '' '疾病信息',
-- 0 '优惠金额',
-- 0 '记账金额',
-- (ms_mzxx.zjje - ms_mzxx.qtys) '医疗自付',
-- (ms_mzxx.zjje - ms_mzxx.qtys) '现金支付',
-- '其他应收' '其他支付类别',
-- ms_mzxx.qtys '金额',
-- ms_brda.dwmc '参保单位',
-- ms_brda.lxdz '家庭地址',
-- ms_brda.jtdh '联系电话',
-- '' '开单医生'
-- from ms_mzxx,ms_brda
-- where ms_mzxx.sfrq >= '2019-07-01'
-- and ms_mzxx.sfrq < '2019-09-01'
-- and ms_mzxx.brid = ms_brda.brid
-- -- and mzlb = 7
-- -- and jgid = 2
-- and ms_mzxx.zfpb = 0
-- union all
-- select
-- ms_brda.mzhm '门诊号',
-- ms_brda.brxm  '姓名',
-- (case ms_brda.brxb when 1 then '男' when 2 then '女' end)  '性别',
-- datediff(yy,ms_brda.csny,getdate())  '年龄',
-- ms_brda.sfzh  '身份证号',
-- (select xzmc from gy_brxz where brxz = ms_mzxx.brxz) '费用类别',
-- ms_brda.ybkh  '医保卡号',
-- ms_mzxx.sfrq '收费日期',
-- ms_mzxx.fphm '发票号码',
-- -1 * ms_mzxx.zjje '费用合计',
-- '' '疾病信息',
-- 0 '优惠金额',
-- 0 '记账金额',
-- -1 * ms_mzxx.xjje '医疗自付',
-- -1 * ms_mzxx.xjje '现金支付',
-- '其他应收' '其他支付类别',
-- -1 * ms_mzxx.qtys '金额',
-- ms_brda.dwmc '参保单位',
-- ms_brda.hkdz '家庭地址',
-- ms_brda.jtdh '联系电话',
-- '' '开单医生'
-- from ms_mzxx,ms_brda
-- where exists (select 1 from ms_zffp where mzxh = ms_mzxx.mzxh and zfrq >= '2019-07-01')
-- -- and ms_mzxx.sfrq < '2019-07-01'
-- and ms_mzxx.brid = ms_brda.brid
-- and mzlb = 7




-- ------2、处方和诊疗明细，
-- select
-- b.brxm '姓名',
-- (select case brxb when 1 then '男' when 2 then '女' end from ms_brda where brid = b.brid) '性别',
-- (select datediff(yy,ms_brda.csny,getdate()) from ms_brda where brid = b.brid) '年龄',
-- (select sfzh from ms_brda where brid = b.brid) '身份证号',
-- b.sfrq '结算时间',
-- a.kfrq '处方时间',
-- (select dwmc from ms_brda where brid = b.brid) '参保单位',
-- (select hkdz from ms_brda where brid = b.brid) '家庭地址',
-- (select jtdh from ms_brda where brid = b.brid) '联系电话',
-- (select xzmc from gy_brxz where brxz = b.brxz) '费用类别',
-- (select ybkh from ms_brda where brid = b.brid) '医保卡号',
-- b.zjje '收费金额',
-- (b.zjje - b.qtys) '医疗自负金额',
-- b.qtys '医保收费金额',
-- (b.zjje - b.qtys) '现金收款金额',
-- b.fphm '发票号码',
-- a.ypmc '药品名称',
-- a.yfgg '规格',
-- a.ypsl  '数量',
-- a.yfdw '单位',
-- a.ypdj '药品单价',
-- a.hjje '药品金额',
-- a.ypcd '生产商',
-- a.ypcd '产地' ,
-- (select  ygxm from gy_ygdm where ygdm = a.ysdm) '医生姓名',
-- '' '疾病信息'
-- from (
--            select 
--            (select ypmc from yk_typk where ypxh = ms_cf02.ypxh) ypmc,
--            ypsl,
--            ypdj,
--            yfdw,
--            hjje,
--            (select cdmc from yk_cddz where ypcd = ms_cf02.ypcd) ypcd,
--            yfgg,
--            ysdm,
--            mzxh,
--            kfrq
--            from ms_cf01,ms_cf02
--            where ms_cf01.cfsb = ms_cf02.cfsb
--            and ms_cf01.mzxh > 0
--            union all
--            select 
--            (select fymc from gy_ylsf where fyxh = ms_yj02.ylxh) ypmc,
--            ylsl,
--            yldj,
--            (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfdw,
--            hjje,
--            '' ypcd,
--            (select fydw from gy_ylsf where fyxh = ms_yj02.ylxh) yfgg,
--            ysdm,
--            mzxh,
--            kdrq kfrq  
--            from ms_yj01,ms_yj02
--            where ms_yj01.yjxh = ms_yj02.yjxh
--            and ms_yj01.mzxh > 0) a,ms_mzxx b
-- where a.mzxh = b.mzxh
-- and b.sfrq >= '2019-07-01'
-- -- and b.sfrq < '2019-07-01'
-- -- and b.mzlb = 7
-- and b.jgid = 2
-- and b.zfpb= 0
-- order by b.mzxh


--3药品明细购销存（中西药都要）、
-- SELECT
-- 名称 '名称',
-- 规格 '规格',
-- 供货商 '供货商',
-- sum(数量金额式) '数量金额式',
-- 进价 '进价',
-- sum(进货金额) '进货金额',
-- 销价 '销价',
-- sum(零售金额) '零售金额'
-- from(
select
(select ypmc from yk_typk where ypxh = yk_rk02.ypxh) '名称',
(select ypgg from yk_typk where ypxh = yk_rk02.ypxh) '规格',
(select dwmc from yk_jhdw where dwxh = yk_rk01.DWXH) '供货商',
yk_rk02.rksl '数量金额式',
yk_rk02.jhjg '进价',
yk_rk02.jhhj '进货金额',
yk_rk02.lsjg '销价',
yk_rk02.lsje '零售金额'
from yk_rk01,yk_rk02
where yk_rk01.xtsb = yk_rk02.xtsb
and yk_rk01.rkfs = yk_rk02.rkfs
and yk_rk01.rkdh = yk_rk02.rkdh
and yk_rk01.rkrq >= '2019-07-01'
and yk_rk01.rkrq < '2019-09-01'
and yk_rk01.rkpb > 0
and yk_rk01.jgid = 2
-- union ALL
-- select
-- (select ypmc from yk_typk where ypxh = yk_rk02.ypxh) '名称',
-- (select ypgg from yk_typk where ypxh = yk_rk02.ypxh) '规格',
-- (select dwmc from yk_jhdw where dwxh = yk_rk01.DWXH) '供货商',
-- yk_rk02.rksl '数量金额式',
-- yk_rk02.jhjg '进价',
-- yk_rk02.jhhj '进货金额',
-- yk_rk02.lsjg '销价',
-- yk_rk02.lsje '零售金额'
-- from hrprun..yk_rk01 yk_rk01,hrprun..yk_rk02 yk_rk02
-- where yk_rk01.xtsb = yk_rk02.xtsb
-- and yk_rk01.rkfs = yk_rk02.rkfs
-- and yk_rk01.rkdh = yk_rk02.rkdh
-- and yk_rk01.rkrq >= '2019-07-01'
-- and yk_rk01.rkrq < '2019-09-01'
-- and yk_rk01.rkbz like '%康安%'
-- and yk_rk01.rkpb > 0) a 
-- group by 名称,规格,供货商,进价,销价


-- 4供应商入库明细,
select 
记账日期 '记账日期',
单据号 '单据号',
发票号 '发票号',
名称 '名称',
规格 '规格',
单位 '单位',
产地厂家 '产地厂家',
入库单号 '入库单号',
购入数量 '购入数量',
进货单价 '进货单价',
购入金额 '购入金额',
零售单价 '零售单价',
零售金额 '零售金额',
进销差额 '进销差额',
有效期限 '有效期限',
生产批号 '生产批号',
批准文号 '批准文号',
成本率 '成本率'
from (
select
yk_rk01.lrrq '记账日期',
yk_rk01.rkdh '单据号',
yk_rk02.fphm '发票号',
(select ypmc from hrprun..yk_typk where ypxh = yk_rk02.ypxh) '名称',
(select ypgg from hrprun..yk_typk where ypxh = yk_rk02.ypxh) '规格',
(select dwmc from hrprun..yk_jhdw where dwxh = yk_rk01.dwxh) '单位',
(select cdmc from hrprun..yk_cddz where ypcd = yk_rk02.ypcd) '产地厂家',
yk_rk01.rkdh '入库单号',
yk_rk02.rksl '购入数量',
yk_rk02.jhjg '进货单价',
yk_rk02.jhhj '购入金额',
yk_rk02.lsjg '零售单价',
yk_rk02.lsje '零售金额',
(yk_rk02.lsje - yk_rk02.jhhj) '进销差额',
yk_rk02.ypxq '有效期限',
yk_rk02.ypph '生产批号',
(select pzwh from hrprun..yk_ypcd where ypxh = yk_rk02.ypxh and ypcd = yk_rk02.ypcd) '批准文号',
jhjg / lsjg '成本率'
from hrprun..yk_rk01 yk_rk01,hrprun..yk_rk02 yk_rk02
where yk_rk01.xtsb = yk_rk02.xtsb
and yk_rk01.rkfs = yk_rk02.rkfs
and yk_rk01.rkdh = yk_rk02.rkdh
and yk_rk01.rkrq >= '2019-07-01'
and yk_rk01.rkrq < '2019-09-01'
and yk_rk01.rkbz like '%康安%'
and yk_rk01.rkpb > 0
union all 
select
yk_rk01.lrrq '记账日期',
yk_rk01.rkdh '单据号',
yk_rk02.fphm '发票号',
(select ypmc from yk_ypml where ypxh = yk_rk02.ypxh) '名称',
(select ypgg from yk_ypml where ypxh = yk_rk02.ypxh) '规格',
(select dwmc from yk_jhdw where dwxh = yk_rk01.dwxh) '单位',
(select cdmc from yk_cddz where ypcd = yk_rk02.ypcd) '产地厂家',
yk_rk01.rkdh '入库单号',
yk_rk02.rksl '购入数量',
yk_rk02.jhjg '进货单价',
yk_rk02.jhhj '购入金额',
yk_rk02.lsjg '零售单价',
yk_rk02.lsje '零售金额',
(yk_rk02.lsje - yk_rk02.jhhj) '进销差额',
yk_rk02.ypxq '有效期限',
yk_rk02.ypph '生产批号',
(select pzwh from yk_ypcd where ypxh = yk_rk02.ypxh and ypcd = yk_rk02.ypcd and jgid = yk_rk01.jgid) '批准文号',
jhjg / lsjg '成本率'
from yk_rk01,yk_rk02
where yk_rk01.xtsb = yk_rk02.xtsb
and yk_rk01.rkfs = yk_rk02.rkfs
and yk_rk01.rkdh = yk_rk02.rkdh
and yk_rk01.rkrq >= '2019-07-01'
and yk_rk01.rkrq < '2019-09-01'
and yk_rk01.jgid = 2
and yk_rk01.rkpb > 0) a




