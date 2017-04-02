;*************************************************************
;Aim: draw OLR annually ltm trend 
;Mission:
;   1. Read data
;   2. Post-post process
;     2.1 take the trend 
;   4. Draw and overlap
;                       Zhenning Li
;                       2015-05-03
;Last Edited:
;   2015-03-01  Create
;   2015-03-03  Change to fit HEAT Experiment
;   2015-04-05  Change to fit Team Server
;   2015-04-08  Change to fit ECMWF MONLTM MEAN
;   2015-05-03  Change to caculate season trend 
;   2015-07-09  Change to caculate OLR
;   2015-07-09  Change to fit composite
;*************************************************************

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin


;================================================
;Variables List:
;	var1--------------U
;	var2--------------V
;================================================
;global variables
    ;Define parameters
    g_data_path1 = "/Users/zhenningli/data/obv/NCEP-DOE/monthly/uwnd.10m.mon.mean.nc"
    g_data_path2 = "/Users/zhenningli/data/obv/NCEP-DOE/monthly/vwnd.10m.mon.mean.nc"
    g_data_path3 = "/Users/zhenningli/data/obv/SST/HadISST_sst.nc"
    g_data_path4 = "/Users/zhenningli/data/obv/PRECT/gpcp.precip.mon.nc"
    
    ;Smaller Region
    g_latS=-20.
    g_latN=20.
    g_lonW=100.
    g_lonE=200.
    
    ; create an array of desired pressure levels:

        
    g_font = 0.02

    g_strt_mon = 197901 
    g_lst_mon = 201512
    g_nyears = g_lst_mon/100-g_strt_mon/100+1
    ; long events larger than 10 months, develop
    g_sp_events = (/198201,198601,199101,199701,201501/)
    ;g_sp_events = (/201501/)
    ; short events with 10 months, develop
    g_su_events = (/197901,199401,200201,200401,200601,200901/)
    ;g_su_events = (/201401/)

    ; long events larger than 10 months, decay
    ;g_sp_events = (/198301,198701,199201,199801/)
    ; short events with 10 months, decay
    ;g_su_events = (/198001,199501,200301,200501,200701,201001/)
    n_sp_events= dimsizes(g_sp_events)
    n_su_events= dimsizes(g_su_events)
    g_fig_name    =   "../fig/paper/FIG2a_"+g_strt_mon+"-"+g_lst_mon+"_SST_Pr-LE-SE-cmp"    
    g_fig_rank    =   (/"(a)","(c)","(c)","(d)","(e)","(f)","(g)","(h)","(i)","(j)","(k)","(l)","(m)","(n)"/)
    
    g_fig_title     = "MAM LE-SE SST & Pr"

;*************************For F_Compset Ctrl***********************************

; ==============================================================
; Mission 1. Open the file: Read only the user specified period
; ==============================================================

	ctrl_file1   = g_data_path1
	ctrl_in1     = addfile (ctrl_file1, "r")   ; note the "s" of addfile
	time_hist    = ctrl_in1->time
    yyyymm  = cd_calendar(time_hist,-1)
    istrt   = ind(yyyymm .eq. g_strt_mon)
    ilast   = ind(yyyymm .eq. g_lst_mon)
	var1  =short2flt(ctrl_in1->uwnd(istrt:ilast,0,:,:))			; p for unify the var name

    ctrl_file2   = g_data_path2
	ctrl_in2     = addfile (ctrl_file2, "r")   ; note the "s" of addfile
	var2  =short2flt(ctrl_in2->vwnd(istrt:ilast,0,:,:))			; p for unify the var name

; ==============================================================
; Mission 2. post-post process data to deserved results
; ==============================================================

    var1=month_to_season12(var1)
    var2=month_to_season12(var2)

    clim_var1=clmMonTLL(var1)
    clim_var2=clmMonTLL(var2)

    smp_sp_var1 = var1(0:12*n_sp_events-1,:,:)
    do ii=0,n_sp_events-1
        i_evstrt= ind(yyyymm .eq. g_sp_events(ii)) - istrt
        smp_sp_var1(ii*12:ii*12+11,:,:) = var1(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_sp_var1_avg = clmMonTLL(smp_sp_var1)

    smp_su_var1 = var1(0:12*n_su_events-1,:,:)
    do ii=0,n_su_events-1
        i_evstrt= ind(yyyymm .eq. g_su_events(ii)) - istrt
        smp_su_var1(ii*12:ii*12+11,:,:) = var1(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_su_var1_avg = clmMonTLL(smp_su_var1)
 
    smp_sp_var2 = var2(0:12*n_sp_events-1,:,:)
    do ii=0,n_sp_events-1
        i_evstrt= ind(yyyymm .eq. g_sp_events(ii)) - istrt
        smp_sp_var2(ii*12:ii*12+11,:,:) = var2(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_sp_var2_avg = clmMonTLL(smp_sp_var2)

    smp_su_var2 = var2(0:12*n_su_events-1,:,:)
    do ii=0,n_su_events-1
        i_evstrt= ind(yyyymm .eq. g_su_events(ii)) - istrt
        smp_su_var2(ii*12:ii*12+11,:,:) = var2(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_su_var2_avg = clmMonTLL(smp_su_var2)

        ; Var3

    ctrl_file3   = g_data_path3
	ctrl_in3     = addfile (ctrl_file3, "r")   ; note the "s" of addfile
	time_hist1    = ctrl_in3->time
    yyyymm1  = cd_calendar(time_hist1,-1)
    istrt   = ind(yyyymm1 .eq. g_strt_mon)
    ilast   = ind(yyyymm1 .eq. g_lst_mon)
	var3  =short2flt(ctrl_in3->sst(istrt:ilast,:,:))		; p for unify the var name
    printVarSummary(var3)
    var3=month_to_season12(var3)
    
    clim_var3=clmMonTLL(var3)
    
    smp_sp_var3 = var3(0:12*n_sp_events-1,:,:)
    do ii=0,n_sp_events-1
        i_evstrt= ind(yyyymm1 .eq. g_sp_events(ii)) - istrt
        smp_sp_var3(ii*12:ii*12+11,:,:) = var3(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_sp_var3_avg = clmMonTLL(smp_sp_var3)

    smp_su_var3 = var3(0:12*n_su_events-1,:,:)
    do ii=0,n_su_events-1
        i_evstrt= ind(yyyymm1 .eq. g_su_events(ii)) - istrt
        print(i_evstrt)
        smp_su_var3(ii*12:ii*12+11,:,:) = var3(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_su_var3_avg = clmMonTLL(smp_su_var3)
   
    clim_var3=clmMonTLL(var3)

    ; Var4

    ctrl_file4   = g_data_path4
	ctrl_in4     = addfile (ctrl_file4, "r")   ; note the "s" of addfile
	time_hist1    := ctrl_in4->time
    yyyymm1  := cd_calendar(time_hist1,-1)
    istrt   = ind(yyyymm1 .eq. g_strt_mon)
    ilast   = ind(yyyymm1 .eq. g_lst_mon)
	var4  =short2flt(ctrl_in4->precip(istrt:ilast,:,:))		; p for unify the var name
    printVarSummary(var4)
    var4=month_to_season12(var4)
    
    clim_var4=clmMonTLL(var4)
    
    smp_sp_var4 = var4(0:12*n_sp_events-1,:,:)
    do ii=0,n_sp_events-1
        i_evstrt= ind(yyyymm1 .eq. g_sp_events(ii)) - istrt
        smp_sp_var4(ii*12:ii*12+11,:,:) = var4(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_sp_var4_avg = clmMonTLL(smp_sp_var4)

    smp_su_var4 = var4(0:12*n_su_events-1,:,:)
    do ii=0,n_su_events-1
        i_evstrt= ind(yyyymm1 .eq. g_su_events(ii)) - istrt
        print(i_evstrt)
        smp_su_var4(ii*12:ii*12+11,:,:) = var4(i_evstrt:i_evstrt+11,:,:)
    end do
    cmp_su_var4_avg = clmMonTLL(smp_su_var4)
   
    cmp_sp_var1_var = cmp_sp_var1_avg
    cmp_su_var1_var = cmp_su_var1_avg
    cmp_sp_var2_var = cmp_sp_var2_avg
    cmp_su_var2_var = cmp_su_var2_avg
    cmp_sp_var3_var = cmp_sp_var3_avg
    cmp_su_var3_var = cmp_su_var3_avg
    cmp_sp_var4_var = cmp_sp_var4_avg
    cmp_su_var4_var = cmp_su_var4_avg
    clim_var1_var = clim_var1
    clim_var2_var = clim_var2
    clim_var3_var = clim_var3
    clim_var4_var = clim_var4

    do ii = 0,11 
        cmp_sp_var1_var(ii,:,:) = dim_variance_n(smp_sp_var1(ii::12,:,:),0)
        cmp_su_var1_var(ii,:,:) = dim_variance_n(smp_su_var1(ii::12,:,:),0)
        cmp_sp_var2_var(ii,:,:) = dim_variance_n(smp_sp_var2(ii::12,:,:),0)
        cmp_su_var2_var(ii,:,:) = dim_variance_n(smp_su_var2(ii::12,:,:),0)
        cmp_sp_var3_var(ii,:,:) = dim_variance_n(smp_sp_var3(ii::12,:,:),0)
        cmp_su_var3_var(ii,:,:) = dim_variance_n(smp_su_var3(ii::12,:,:),0)
        cmp_sp_var4_var(ii,:,:) = dim_variance_n(smp_sp_var4(ii::12,:,:),0)
        cmp_su_var4_var(ii,:,:) = dim_variance_n(smp_su_var4(ii::12,:,:),0)
        
        clim_var1_var(ii,:,:) = dim_variance_n(var1(ii::12,:,:),0)
        clim_var2_var(ii,:,:) = dim_variance_n(var2(ii::12,:,:),0)
        clim_var3_var(ii,:,:) = dim_variance_n(var3(ii::12,:,:),0)
        clim_var4_var(ii,:,:) = dim_variance_n(var4(ii::12,:,:),0)
    end do
    cmp_var1_sp = cmp_sp_var1_avg
    cmp_var1_sp = cmp_sp_var1_avg - clim_var1
    cmp_var2_sp = cmp_sp_var2_avg
    cmp_var2_sp = cmp_sp_var2_avg - clim_var2 
    cmp_var3_sp = cmp_sp_var3_avg
    cmp_var3_sp = cmp_sp_var3_avg - clim_var3
    cmp_var4_sp = cmp_sp_var4_avg
    cmp_var4_sp = cmp_sp_var4_avg - clim_var4

    cmp_var1_all = cmp_sp_var1_avg
    cmp_var1_all = cmp_sp_var1_avg - cmp_su_var1_avg
    cmp_var2_all = cmp_sp_var2_avg
    cmp_var2_all = cmp_sp_var2_avg - cmp_su_var2_avg
    cmp_var3_all = cmp_sp_var3_avg
    cmp_var3_all = cmp_sp_var3_avg - cmp_su_var3_avg
    cmp_var4_all = cmp_sp_var4_avg
    cmp_var4_all = cmp_sp_var4_avg - cmp_su_var4_avg


    ;--------------------------------
    ;--------Sig Test----------------
    ;--------------------------------
  
    siglvl = 0.1                       ; critical sig lvl for r

    iflag= False                        ; population variance similar
    diff_var1_sp_sig = cmp_var1_sp
    diff_var2_sp_sig = cmp_var2_sp
    diff_var3_sp_sig = cmp_var3_sp
    diff_var4_sp_sig = cmp_var4_sp
    do ii = 0,11
        prob1 = ttest(cmp_sp_var1_avg(ii,:,:),cmp_sp_var1_var(ii,:,:),n_sp_events, clim_var1(ii,:,:), clim_var1_var(ii,:,:), g_nyears, iflag, False) 
        prob2 = ttest(cmp_sp_var2_avg(ii,:,:),cmp_sp_var2_var(ii,:,:),n_sp_events, clim_var2(ii,:,:), clim_var2_var(ii,:,:), g_nyears, iflag, False) 
        prob3 = ttest(cmp_sp_var3_avg(ii,:,:),cmp_sp_var3_var(ii,:,:),n_sp_events, clim_var3(ii,:,:), clim_var3_var(ii,:,:), g_nyears, iflag, False) 
        prob4 = ttest(cmp_sp_var4_avg(ii,:,:),cmp_sp_var4_var(ii,:,:),n_sp_events, clim_var4(ii,:,:), clim_var4_var(ii,:,:), g_nyears, iflag, False) 
        diff_var3_sp_sig(ii,:,:) = mask(cmp_var3_sp(ii,:,:), prob3 .lt. siglvl,True)
        diff_var4_sp_sig(ii,:,:) = mask(cmp_var4_sp(ii,:,:), prob4 .lt. siglvl,True)
        diff_var1_sp_sig(ii,:,:)= (/mask(cmp_var1_sp(ii,:,:),(prob1 .lt. siglvl) .or. (prob2 .lt. siglvl),True)/)    
    end do

    siglvl=0.12
    ;su means LE-SE
    diff_var1_all_sig = cmp_var1_all
    diff_var2_all_sig = cmp_var2_all
    diff_var3_all_sig = cmp_var3_all
    diff_var4_all_sig = cmp_var4_all
    do ii = 0,11
        prob1 = ttest(cmp_sp_var1_avg(ii,:,:),cmp_sp_var1_var(ii,:,:),n_sp_events,cmp_su_var1_avg(ii,:,:),cmp_su_var1_var(ii,:,:), n_su_events, iflag, False) 
        prob2 = ttest(cmp_sp_var2_avg(ii,:,:),cmp_sp_var2_var(ii,:,:),n_sp_events,cmp_su_var2_avg(ii,:,:),cmp_su_var2_var(ii,:,:), n_su_events, iflag, False) 
        prob3 = ttest(cmp_sp_var3_avg(ii,:,:),cmp_sp_var3_var(ii,:,:),n_sp_events,cmp_su_var3_avg(ii,:,:),cmp_su_var3_var(ii,:,:), n_su_events, iflag, False) 
        prob4 = ttest(cmp_sp_var4_avg(ii,:,:),cmp_sp_var4_var(ii,:,:),n_sp_events,cmp_su_var4_avg(ii,:,:),cmp_su_var4_var(ii,:,:), n_su_events, iflag, False) 
        diff_var3_all_sig(ii,:,:) = mask(cmp_var3_all(ii,:,:), prob3 .lt. siglvl,True)
        diff_var4_all_sig(ii,:,:) = mask(cmp_var4_all(ii,:,:), prob4 .lt. siglvl,True)
        diff_var1_all_sig(ii,:,:)= (/mask(cmp_var1_all(ii,:,:),(prob1 .lt. siglvl) .or. (prob2 .lt. siglvl),True)/)    
    end do


;Fig

    wks = gsn_open_wks("eps",g_fig_name)  ; open a ps file

    
;  wks = gsn_open_wks("pdf","up_T_surface_cte_mean_250-400hPa")  ; open a ps file
;  wks = gsn_open_wks("x11","diabatic_heat_250-500hPa")  ; open a ps file

  plot = new((/2/),graphic)
  plot_cn_pos = new((/2/),graphic)
  plot_cn_neg = new((/2/),graphic)
  plot_sig = new((/2/),graphic)
  plot_sig2 = new((/2/),graphic)
  plot_V = new((/2/),graphic)

;  gsn_define_colormap(wks,"BlAqGrYeOrReVi200") ; choose a colormap 
;   gsn_define_colormap(wks,"Rainbow") ; choose a colormap
;   gsn_define_colormap(wks,"BlGrYeOrReVi200") ; choose a colormap
;  gsn_define_colormap(wks,"precip4_diff_19lev")
;  gsn_define_colormap(wks,"precip_diff_12lev")
; gsn_define_colormap(wks,"BkBlAqGrYeOrReViWh200")
; gsn_define_colormap(wks,"WhiteBlueGreenYellowRed")
 gsn_define_colormap(wks,"ViBlGrWhYeOrRe")
; gsn_define_colormap(wks,"BlueRed")
;-----------------------------------------------------------------------------
  res                  = True       ; use plot options

  res@cnFillOn             = True               ; turn on color for contours
  res@cnLinesOn            = False              ; turn off contour lines
  res@cnLineLabelsOn       = False              ; turn off contour line labels



;  i = NhlNewColor(wks,0.341,0.,0.533)              ; add gray to colormap
;  j = NhlNewColor(wks,1,0.,0.)
;  res@mpLandFillColor       = "gray"            ; set land to be gray

;  res@cnLevelSelectionMode = "ExplicitLevels"   ; set manual contour levels
;  res@cnLevels = (/-5,-4.5,-4,-3.5,-3,-2.5,-2,-1.5,-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5/)
;   res@cnLevels = ispan(0,60,10)
;  res@cnFillColors =(/-1,20,47,57,94,127,152/)
;    res@cnLevelSelectionMode = "ExplicitLevels"   ; set manual contour levels
;    res@cnLevels =    (/-0.8,-0.4,-0.2, 0.0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.5, 2.0, 2.5, 3.0/)
;    res@cnFillColors =(/   2,  18,  34,  52,  61,  68,  77,  82,  87,  91,  95,  99, 100, 102/)
    res@cnLevelSelectionMode  = "ManualLevels" ; set manual contour levels
    res@cnMinLevelValF        =  -0.6          ; set min contour level
    res@cnMaxLevelValF        =  0.6          ; set max contour level
    res@cnLevelSpacingF       =  0.1          ; set contour interval
;  res@cnFillColors =(/2,4,7,8,8,9,11,13/)


  res@gsnFrame         = False
  res@gsnDraw  = False
  
  res@gsnSpreadColors      = True               ; use full color map
  res@gsnSpreadColorStart  = 15               ; start at color 17
  res@gsnSpreadColorEnd    = 101-10                ; end at color 200

;  res@gsnPanelLabelBar    = True   ;Turn on panel labelbar
  res@gsnStringFontHeightF = g_font 

  res@gsnMaximize      = True       ; fill up the page
  res@gsnAddCyclic   = True;False
  res@gsnPaperOrientation = "portrait"
  res@gsnContourZeroLineThicknessF = 2.  ;set thickness of zero


  res@lbLabelBarOn = True   ; turn off the label bar
 ; res@lbOrientation          = "vertical"
  res@lbLabelFontHeightF  = 0.02              ; make labels smaller
  ;res@lbLabelStride = 1

  res@mpFillOn   = True     ; turn off gray continents
  res@mpGeophysicalLineThicknessF = 2 
  res@mpGeophysicalLineColor      = "black";"white" 
  res@mpFillDrawOrder="PostDraw"
  res@mpCenterLonF = 180.
  res@mpMaxLatF  = g_latN
  res@mpMinLatF  = g_latS
  res@mpMaxLonF  = g_lonE
  res@mpMinLonF  = g_lonW

;  res@mpShapeMode = "FreeAspect" 

;  res@vpWidthF = 0.8
;  res@vpHeightF = 0.6

;  res@tmXBMajorOutwardLengthF = -0.
;  res@tmYLMajorOutwardLengthF = -0.
;  res@tmYRMajorOutwardLengthF = -0.
  
;  res@tmXBMinorOutwardLengthF = -0.
;  res@tmYLMinorOutwardLengthF = -0.
;  res@tmYRMinorOutwardLengthF = -0.
    
     ; now change the size of the tickmark labels
  res@tmXBTickSpacingF = 30
  res@tmYLTickSpacingF = 10
  res@tmXBLabelFontHeightF = 0.02 
; res@tmXBLabelFontAspectF = 1.6
  res@tmXBLabelFontThicknessF = 2.0
  res@tmYLLabelFontHeightF = 0.02
; res@tmYLLabelFontAspectF = 1.3
  res@tmYLLabelFontThicknessF = 2.0
; res@tmYLLabelFontQuality =


;-----------------------------------------------------------------------------
    res3                  = True       ; use plot options
    res3@cnFillOn         = False;True       ; Fill contours
    res3@cnLinesOn        = True      ; turn off contour lines
    ;for tp masking
    res3@gsnFrame         = False
    res3@gsnDraw  = False
    res3@cnLineLabelsOn   = False      ; turn off contour line labels
    res3@cnLineThicknessF = 1.5 
    res3@cnInfoLabelOn = False


    res3@cnLevelSelectionMode="ExplicitLevels"
    res3@cnLevels = (/1.0, 1.5, 2.0, 2.5/)
    res3@cnLineColor      = "Blue"
    res3@gsnLeftString      = " "
    res3@gsnRightString      = " "

    cmp_var4_sp=smth9_Wrap(cmp_var4_sp,0.5,0.25, True)
    ;plot_cn_pos(0) = gsn_csm_contour(wks,cmp_var4_sp(3,:,:),res3) ; create a default plot
    cmp_var4_all=smth9_Wrap(cmp_var4_all,0.5,0.25, True)
    plot_cn_pos(1) = gsn_csm_contour(wks,cmp_var4_all(3,:,:),res3) ; create a default plot
    
    res3@cnLevels = -res3@cnLevels
    res3@cnLineColor      = "Red"
    res3@cnLineDashPattern      = 1
    ;plot_cn_neg(0) = gsn_csm_contour(wks,cmp_var4_sp(3,:,:),res3) ; create a default plot
    plot_cn_neg(1) = gsn_csm_contour(wks,cmp_var4_all(3,:,:),res3) ; create a default plot

    res5=res3
    res5@cnLevels:=(/28.0/)
    res5@cnLineColor      = "Black"
    res5@cnLineDashPattern      = 0
    res5@cnLineThicknessF = 2
    plot_sst_cmp = gsn_csm_contour(wks,cmp_sp_var3_avg(3,:,:),res5) ; create a default plot

    res5@cnLineColor      = "Gray35"
    res5@cnLineDashPattern      = 1
    plot_sst_clim = gsn_csm_contour(wks,clim_var3(3,:,:),res5) ; create a default plot

;-------------------------------------------------
;-----------------------------------------------------
  res4                  = True       ; use plot options
  res4@cnFillOn         = True       ; Fill contours
  res4@cnLinesOn        = False;True      ; turn off contour lines
  res4@gsnFrame         = False
  res4@gsnDraw  = False
  res4@cnLineLabelsOn   = False      ; turn off contour line labels
  res4@cnLineThicknessF = 2
  res4@cnLineColor      = "red"
  res4@cnInfoLabelOn = False
  res4@cnMonoFillPattern    = True;False
  res4@cnFillPattern = 3
  res4@cnMonoFillScale = True
  res4@cnFillScaleF = 0.6 
  res4@cnMonoFillColor = True
  res4@cnFillColor  =  "black"
  res4@cnFillDotSizeF = 0.0025
 
  res4@lbLabelBarOn = False;True   ; turn off the label bar
 
;  res4@cnLevelSelectionMode="ExplicitLevels"
;  res4@cnLevels = (/3000,1000/)
  res4@gsnLeftString      = " "
  res4@gsnRightString      = " "
 
;-----------------------------------------------------------------------------
     ;-----------------------------------------------------------------------------
       ;-------Set for the vector plot------
    vcres = True
    vcres@gsnDraw          = False           ; don't draw
    vcres@gsnFrame         = False           ; don't advance frame
    vcres@gsnRightString   = " "             ; turn off right string
    vcres@gsnLeftString    = " "             ; turn off left string
    vcres@gsnCenterString    = " "

    vcres@vcRefAnnoOn      = True
    vcres@vcRefAnnoOrthogonalPosF = -1             ; move ref vector up
    vcres@vcRefMagnitudeF         = 3.0             ; define vector ref mag
    vcres@vcRefLengthF            = 0.045            ; define length of vec ref
    vcres@vcGlyphStyle            = "LineArrow"    ; turn on curly vectors
    vcres@vcMinDistanceF          = 0.032
    vcres@vcRefAnnoString1  = "3 m/s"
    vcres@vcRefAnnoString2  = ""
    vcres@vcRefAnnoFontHeightF = 0.012
    vcres@vcLineArrowThicknessF     = 2    ;thickness of vector

    vcres@vcLineArrowHeadMinSizeF   = 0.01
    vcres@vcLineArrowHeadMaxSizeF   = 0.01       
    
    
    res@gsnLeftString = g_fig_rank(0)
    res@gsnCenterString = g_fig_title(0)
    res@gsnRightString = ""

    ;plot(0) = gsn_csm_contour_map_ce(wks,cmp_var3_sp(3,:,:),res)
    
    res@gsnLeftString = g_fig_rank(0)
    res@gsnCenterString = g_fig_title(0)
    res@gsnRightString = ""
    plot(1) = gsn_csm_contour_map_ce(wks,diff_var3_all_sig(3,:,:),res)

    ;plot_sig(0) = gsn_csm_contour(wks,diff_var3_sp_sig(3,:,:),res4)  ; Create shaded contours
   ; plot_sig(1) = gsn_csm_contour(wks,diff_var3_all_sig(3,:,:),res4)  ; Create shaded contours
    
    res4@cnFillPattern=7
    res4@cnFillColor="black"
    ;plot_sig2(0) = gsn_csm_contour(wks,diff_var4_sp_sig(3,:,:),res4)  ; Create shaded contours
    plot_sig2(1) = gsn_csm_contour(wks,diff_var4_all_sig(3,:,:),res4)  ; Create shaded contours
    
    ;plot_V(0) = gsn_csm_vector(wks,diff_var1_sp_sig(3,:,:),diff_var2_sp_sig(3,:,:),vcres)
    ;plot_V(1) = gsn_csm_vector(wks,diff_var1_all_sig(3,:,:),diff_var2_all_sig(3,:,:),vcres)
    
    do i=1, 1
        ;overlay(plot(i),plot_V(i))
        ;overlay(plot(i),plot_sig(i))
        overlay(plot(i),plot_sig2(i))
        overlay(plot(i),plot_sst_cmp)
        overlay(plot(i),plot_sst_clim)
        overlay(plot(i),plot_cn_neg(i))
        overlay(plot(i),plot_cn_pos(i))
    end do
    gsn_panel(wks,plot(1),(/1,1/),False) 
  
  end 