; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine-unsafe-select-transform=0 -instcombine -S | FileCheck %s

define i1 @a_true_implies_b_true(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_true_implies_b_true(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 20
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 [[X:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 20
  %b = icmp ugt i8 %z, 10
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = select i1 %a, i1 %sel, i1 false
  ret i1 %res
}

define <2 x i1> @a_true_implies_b_true_vec(i8 %z0, <2 x i1> %X, <2 x i1> %Y) {
; CHECK-LABEL: @a_true_implies_b_true_vec(
; CHECK-NEXT:    [[A0:%.*]] = insertelement <2 x i8> poison, i8 [[Z0:%.*]], i8 0
; CHECK-NEXT:    [[Z:%.*]] = shufflevector <2 x i8> [[A0]], <2 x i8> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[A:%.*]] = icmp ugt <2 x i8> [[Z]], <i8 20, i8 19>
; CHECK-NEXT:    [[B:%.*]] = icmp ugt i8 [[Z0]], 10
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[B]], <2 x i1> [[X:%.*]], <2 x i1> [[Y:%.*]]
; CHECK-NEXT:    [[RES:%.*]] = select <2 x i1> [[A]], <2 x i1> [[SEL]], <2 x i1> zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[RES]]
;

  %a0 = insertelement <2 x i8> poison, i8 %z0, i8 0
  %z = shufflevector <2 x i8> %a0, <2 x i8> poison, <2 x i32> zeroinitializer
  %a = icmp ugt <2 x i8> %z, <i8 20, i8 19>
  %b = icmp ugt i8 %z0, 10
  %sel = select i1 %b, <2 x i1> %X, <2 x i1> %Y
  %res = select <2 x i1> %a, <2 x i1> %sel, <2 x i1> zeroinitializer
  ret <2 x i1> %res
}

define i1 @a_true_implies_b_true2(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_true_implies_b_true2(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 20
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 [[X:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 20
  %b = icmp ugt i8 %z, 10
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = and i1 %a, %sel
  ret i1 %res
}

define i1 @a_true_implies_b_true2_comm(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_true_implies_b_true2_comm(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 20
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 [[X:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 20
  %b = icmp ugt i8 %z, 10
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = and i1 %sel, %a
  ret i1 %res
}

define i1 @a_true_implies_b_false(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_true_implies_b_false(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 20
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 [[Y:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 20
  %b = icmp ult i8 %z, 10
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = select i1 %a, i1 %sel, i1 false
  ret i1 %res
}

define i1 @a_true_implies_b_false2(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_true_implies_b_false2(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 20
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 [[Y:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 20
  %b = icmp eq i8 %z, 10
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = and i1 %a, %sel
  ret i1 %res
}

define i1 @a_true_implies_b_false2_comm(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_true_implies_b_false2_comm(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 20
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 [[Y:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 20
  %b = icmp eq i8 %z, 10
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = and i1 %sel, %a
  ret i1 %res
}

define i1 @a_false_implies_b_true(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_false_implies_b_true(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 10
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 true, i1 [[X:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 10
  %b = icmp ult i8 %z, 20
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = select i1 %a, i1 true, i1 %sel
  ret i1 %res
}

define i1 @a_false_implies_b_true2(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_false_implies_b_true2(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 10
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 true, i1 [[X:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 10
  %b = icmp ult i8 %z, 20
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = or i1 %a, %sel
  ret i1 %res
}

define i1 @a_false_implies_b_true2_comm(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_false_implies_b_true2_comm(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 10
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 true, i1 [[X:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 10
  %b = icmp ult i8 %z, 20
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = or i1 %sel, %a
  ret i1 %res
}

define i1 @a_false_implies_b_false(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_false_implies_b_false(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 10
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 true, i1 [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 10
  %b = icmp ugt i8 %z, 20
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = select i1 %a, i1 true, i1 %sel
  ret i1 %res
}

define i1 @a_false_implies_b_false2(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_false_implies_b_false2(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 10
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 true, i1 [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 10
  %b = icmp ugt i8 %z, 20
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = or i1 %a, %sel
  ret i1 %res
}

define i1 @a_false_implies_b_false2_comm(i8 %z, i1 %X, i1 %Y) {
; CHECK-LABEL: @a_false_implies_b_false2_comm(
; CHECK-NEXT:    [[A:%.*]] = icmp ugt i8 [[Z:%.*]], 10
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A]], i1 true, i1 [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a = icmp ugt i8 %z, 10
  %b = icmp ugt i8 %z, 20
  %sel = select i1 %b, i1 %X, i1 %Y
  %res = or i1 %sel, %a
  ret i1 %res
}
