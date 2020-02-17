function cmap = cm_haline(varargin)

% CM_HALINE: 256 color palette from CMOCEAN
%
% cmap = cm_haline(M)
%
% HALINE colormap by Kristen Thyng.
%
% On Input:
%
%    M        Number of colors (integer, OPTIONAL)
%
% On Ouput:
%
%    cmap     Mx3 colormap matrix
%
% Usage:
%
%    colormap(cm_haline)
%    colormap(flipud(cm_haline))
%
% https://github.com/matplotlib/cmocean/tree/master/cmocean/rgb
%
% Thyng, K.M., C.A. Greene, R.D. Hetland, H.M. Zimmerle, and S.F DiMarco, 2016:
%   True colord of oceanography: Guidelines for effective and accurate colormap
%   selection, Oceanography, 29(3), 9-13, http://dx.doi.org/10.5670/oceanog.2016.66 
% 

% svn $Id: cm_haline.m 938 2019-01-28 06:35:10Z arango $

% Initialize.

switch numel(varargin)
  case 0
    M = 256;
  case 1
    M = varargin{1};
end

% Set 256 colormap.

cmap = [[1.629529545569048110e-01, 9.521591660747855124e-02, 4.225729247643043585e-01],
        [1.648101130638113809e-01, 9.635115909727909322e-02, 4.318459659833655540e-01],
        [1.666161667445505146e-01, 9.744967053737302320e-02, 4.412064832719169161e-01],
        [1.683662394047173716e-01, 9.851521320092249123e-02, 4.506510991070378780e-01],
        [1.700547063176806595e-01, 9.955275459284393391e-02, 4.601751103492678907e-01],
        [1.716750780810941956e-01, 1.005687314559364776e-01, 4.697722208210775574e-01],
        [1.732198670017069397e-01, 1.015713570251385311e-01, 4.794342308257477092e-01],
        [1.746804342417165035e-01, 1.025709733421875103e-01, 4.891506793097686878e-01],
        [1.760433654254164593e-01, 1.035658402770499587e-01, 4.989416012077843576e-01],
        [1.772982333235153807e-01, 1.045802467658180357e-01, 5.087715885336102639e-01],
        [1.784322966250933284e-01, 1.056380265564063059e-01, 5.186108302832771466e-01],
        [1.794226692010022772e-01, 1.067416562108134404e-01, 5.284836071020164727e-01],
        [1.802542327126359922e-01, 1.079356346679062328e-01, 5.383245681077661882e-01],
        [1.808975365813079994e-01, 1.092386640641496154e-01, 5.481352134375515606e-01],
        [1.813298273265454008e-01, 1.107042924622455293e-01, 5.578435355461390799e-01],
        [1.815069308605478937e-01, 1.123613365530294061e-01, 5.674471854200233700e-01],
        [1.813959559086370799e-01, 1.142804413027345978e-01, 5.768505865319291104e-01],
        [1.809499433760710929e-01, 1.165251530113385336e-01, 5.859821014031293407e-01],
        [1.801166524094891808e-01, 1.191682999758127970e-01, 5.947494236872948870e-01],
        [1.788419557731087683e-01, 1.222886104999623413e-01, 6.030366129604394221e-01],
        [1.770751344832933727e-01, 1.259620672997293078e-01, 6.107077426144936760e-01],
        [1.747764954226868062e-01, 1.302486445940692350e-01, 6.176174300439590814e-01],
        [1.719255883800615836e-01, 1.351768519397535118e-01, 6.236290832033221099e-01],
        [1.685302279919113078e-01, 1.407308818346016399e-01, 6.286357211183263294e-01],
        [1.646373543798159977e-01, 1.468433194330099889e-01, 6.325796572366660930e-01],
        [1.603141656593721487e-01, 1.534074847391770635e-01, 6.354701889106297852e-01],
        [1.556539455727427579e-01, 1.602911795924207572e-01, 6.373742153046678682e-01],
        [1.507373567977903506e-01, 1.673688895313445446e-01, 6.383989700654711941e-01],
        [1.456427577979826360e-01, 1.745293312408868480e-01, 6.386687569056349600e-01],
        [1.404368075255880977e-01, 1.816841459042554952e-01, 6.383089542091028301e-01],
        [1.351726504089350855e-01, 1.887688275072176014e-01, 6.374350053971095109e-01],
        [1.298906561807787186e-01, 1.957398580438490798e-01, 6.361469852044080442e-01],
        [1.246205125693149729e-01, 2.025703385486158914e-01, 6.345282558695404251e-01],
        [1.193859004780570554e-01, 2.092446623034395214e-01, 6.326478270215730726e-01],
        [1.142294912197052703e-01, 2.157456284251405010e-01, 6.305768690676523125e-01],
        [1.091404911375367659e-01, 2.220831206181900774e-01, 6.283455167242665285e-01],
        [1.041438584244326337e-01, 2.282546518282705383e-01, 6.259979600528258192e-01],
        [9.926304855671816418e-02, 2.342609767388125763e-01, 6.235717761795677161e-01],
        [9.449512580805050077e-02, 2.401139958170242505e-01, 6.210816676451920149e-01],
        [8.986951574154733446e-02, 2.458147193889331228e-01, 6.185591936304666305e-01],
        [8.539285840535987271e-02, 2.513729453557033144e-01, 6.160166295227810229e-01],
        [8.106756674391193962e-02, 2.567997050291829786e-01, 6.134596708213713168e-01],
        [7.694418932732069449e-02, 2.620915612909199277e-01, 6.109238301118911085e-01],
        [7.300703739422578775e-02, 2.672655035330154250e-01, 6.083965011432549419e-01],
        [6.927650669442811382e-02, 2.723273008096985248e-01, 6.058873223830183452e-01],
        [6.578801445169751849e-02, 2.772789491245566951e-01, 6.034141752438300088e-01],
        [6.255595479554787453e-02, 2.821282390686886132e-01, 6.009787922718963227e-01],
        [5.959205181913470456e-02, 2.868831717247524726e-01, 5.985797542127682114e-01],
        [5.691772151374491912e-02, 2.915488716281217640e-01, 5.962214962176209943e-01],
        [5.455347307306369214e-02, 2.961302536799313989e-01, 5.939076044300871660e-01],
        [5.251889627870443694e-02, 3.006318409387543356e-01, 5.916414807294642086e-01],
        [5.083877347247430650e-02, 3.050562292020492783e-01, 5.894315315373579445e-01],
        [4.951454037014189208e-02, 3.094102218220906031e-01, 5.872714908845412252e-01],
        [4.855490408104565919e-02, 3.136977658751046727e-01, 5.851627302038014955e-01],
        [4.796369156225028380e-02, 3.179225992994973993e-01, 5.831062484926557987e-01],
        [4.773946305380068894e-02, 3.220882581897950847e-01, 5.811027291021745311e-01],
        [4.787545181415154422e-02, 3.261980852298422273e-01, 5.791525884087008746e-01],
        [4.835984720504159923e-02, 3.302552388254387794e-01, 5.772560174768572860e-01],
        [4.917638757411300215e-02, 3.342627026038174076e-01, 5.754130176762238813e-01],
        [5.030518671680884318e-02, 3.382232950310170572e-01, 5.736234310853615126e-01],
        [5.172369283691292258e-02, 3.421396789632700219e-01, 5.718869664041401624e-01],
        [5.340767549062541003e-02, 3.460143709989857430e-01, 5.702032209969470911e-01],
        [5.533215100674954839e-02, 3.498497505368459159e-01, 5.685716996038682192e-01],
        [5.747218306369886870e-02, 3.536480684754851334e-01, 5.669918301827847618e-01],
        [5.980352430527090951e-02, 3.574114555130643578e-01, 5.654629772812437283e-01],
        [6.230309069250609261e-02, 3.611419300223894235e-01, 5.639844532816007394e-01],
        [6.494927925026378057e-02, 3.648414054902228698e-01, 5.625555278152573058e-01],
        [6.772215122553368327e-02, 3.685116975190721456e-01, 5.611754356007422340e-01],
        [7.060350747784929770e-02, 3.721545303967777607e-01, 5.598433829250933913e-01],
        [7.357840396611611822e-02, 3.757710087912914942e-01, 5.585612898846836760e-01],
        [7.663101364217325684e-02, 3.793629991309988569e-01, 5.573268773673928367e-01],
        [7.974739830752586300e-02, 3.829322364932883360e-01, 5.561380319387883020e-01],
        [8.291580548873803136e-02, 3.864801413799028307e-01, 5.549938581786431069e-01],
        [8.612580955679122185e-02, 3.900080689665953448e-01, 5.538934528024703763e-01],
        [8.936817980172057085e-02, 3.935173134989205512e-01, 5.528359060062189023e-01],
        [9.263475301781654014e-02, 3.970091123550867351e-01, 5.518203023495191761e-01],
        [9.591831391237073956e-02, 4.004846497947374129e-01, 5.508457212473490960e-01],
        [9.921323508992196949e-02, 4.039446967979293257e-01, 5.499133654313189679e-01],
        [1.025139614653171327e-01, 4.073902646845309894e-01, 5.490228475752887416e-01],
        [1.058144853522852702e-01, 4.108228877965505177e-01, 5.481703859285301794e-01],
        [1.091104131658914012e-01, 4.142435690118807523e-01, 5.473550236322454188e-01],
        [1.123978495089298091e-01, 4.176532725696484594e-01, 5.465757987301745890e-01],
        [1.156733362160069500e-01, 4.210529263321469151e-01, 5.458317432175192607e-01],
        [1.189341701380315364e-01, 4.244432161011251203e-01, 5.451231873866256850e-01],
        [1.221781892974011241e-01, 4.278246691926565481e-01, 5.444513010684173260e-01],
        [1.254018943745988379e-01, 4.311987106338182607e-01, 5.438113725374379426e-01],
        [1.286031296249826039e-01, 4.345661396549306832e-01, 5.432023919026625070e-01],
        [1.317799711665625373e-01, 4.379277275711909168e-01, 5.426233385794481112e-01],
        [1.349307019221451520e-01, 4.412842189714309415e-01, 5.420731800699918335e-01],
        [1.380549051543558114e-01, 4.446356900078314855e-01, 5.415550926551251365e-01],
        [1.411501069188544899e-01, 4.479834819017672332e-01, 5.410638066180113448e-01],
        [1.442150210041465985e-01, 4.513283116704150388e-01, 5.405979268760919831e-01],
        [1.472485820103837661e-01, 4.546708245755168298e-01, 5.401563599016087069e-01],
        [1.502499341655997578e-01, 4.580115969309521140e-01, 5.397383042732707414e-01],
        [1.532192022679761678e-01, 4.613507130792227628e-01, 5.393460827274304537e-01],
        [1.561545863558880531e-01, 4.646893652629560667e-01, 5.389744586257710912e-01],
        [1.590554825896313418e-01, 4.680281092699005163e-01, 5.386222668134232894e-01],
        [1.619213854747377779e-01, 4.713674796485894380e-01, 5.382883230992108192e-01],
        [1.647524478987731911e-01, 4.747077026242289555e-01, 5.379733478625169374e-01],
        [1.675482630437002962e-01, 4.780493319379570116e-01, 5.376757027790604049e-01],
        [1.703080688452488778e-01, 4.813931150452205876e-01, 5.373922894579649112e-01],
        [1.730317245949949956e-01, 4.847395013664480001e-01, 5.371218460871988176e-01],
        [1.757193664968157432e-01, 4.880888303994977417e-01, 5.368636833242294015e-01],
        [1.783716503259393793e-01, 4.914412289641479359e-01, 5.366183612997760255e-01],
        [1.809878167761821144e-01, 4.947975030047193079e-01, 5.363817525707026412e-01],
        [1.835680719416625251e-01, 4.981580161432020426e-01, 5.361525222751042374e-01],
        [1.861127112291278973e-01, 5.015231101060642072e-01, 5.359293193132266264e-01],
        [1.886230405888700001e-01, 5.048927132825591357e-01, 5.357133548543864254e-01],
        [1.910985251486422565e-01, 5.082675669534003626e-01, 5.355003101591436776e-01],
        [1.935397227717326196e-01, 5.116479477164066481e-01, 5.352887824024628038e-01],
        [1.959472883340568350e-01, 5.150341080561433582e-01, 5.350773667248226451e-01],
        [1.983227076664061950e-01, 5.184259856373716335e-01, 5.348665525352744865e-01],
        [2.006660342507454731e-01, 5.218241099237964642e-01, 5.346528031121534630e-01],
        [2.029781360478647434e-01, 5.252286912572143862e-01, 5.344345169358406533e-01],
        [2.052600444742044838e-01, 5.286398903414566419e-01, 5.342102605335536936e-01],
        [2.075134652380221101e-01, 5.320576287402744020e-01, 5.339799959048032729e-01],
        [2.097389494614402272e-01, 5.354822793223580346e-01, 5.337406085215398166e-01],
        [2.119377691272176234e-01, 5.389139515314046447e-01, 5.334905459074957834e-01],
        [2.141113437844118228e-01, 5.423527133674995726e-01, 5.332283775266504211e-01],
        [2.162615771757636085e-01, 5.457984712571943842e-01, 5.329535750363618707e-01],
        [2.183895286205785324e-01, 5.492514494924778390e-01, 5.326634150194080597e-01],
        [2.204969036245257863e-01, 5.527116487772890663e-01, 5.323564832742772035e-01],
        [2.225855272635121618e-01, 5.561790393438251767e-01, 5.320314302436226495e-01],
        [2.246573660062902156e-01, 5.596535532346759156e-01, 5.316870266023980829e-01],
        [2.267141352300188206e-01, 5.631352211554988552e-01, 5.313212748929951879e-01],
        [2.287579175696445311e-01, 5.666239548700177098e-01, 5.309328290550865415e-01],
        [2.307908679682200148e-01, 5.701196510565367248e-01, 5.305203252817071169e-01],
        [2.328150701112509102e-01, 5.736222405040750649e-01, 5.300820599240353426e-01],
        [2.348328561421904603e-01, 5.771315766359990107e-01, 5.296167282704775658e-01],
        [2.368466495707550745e-01, 5.806474896434283828e-01, 5.291230766564496424e-01],
        [2.388588283644081933e-01, 5.841698333340915594e-01, 5.285995915811123602e-01],
        [2.408716822240541400e-01, 5.876984999166237067e-01, 5.280443921862176815e-01],
        [2.428880608722543410e-01, 5.912331932277818947e-01, 5.274567814051942527e-01],
        [2.449106759672304290e-01, 5.947736703172152861e-01, 5.268356212312692577e-01],
        [2.469420290965465559e-01, 5.983197676291379663e-01, 5.261791312000029253e-01],
        [2.489846702882144713e-01, 6.018713111492172141e-01, 5.254854952988164962e-01],
        [2.510418446331669773e-01, 6.054278820406324702e-01, 5.247545535679302153e-01],
        [2.531164830585315162e-01, 6.089891735215487989e-01, 5.239852980594518206e-01],
        [2.552111567013787274e-01, 6.125550130731924892e-01, 5.231756545447472373e-01],
        [2.573286340449815746e-01, 6.161251617120727664e-01, 5.223239185167128928e-01],
        [2.594724447386158594e-01, 6.196990932330638246e-01, 5.214304767886038805e-01],
        [2.616456589963800927e-01, 6.232764459181282524e-01, 5.204944566826074093e-01],
        [2.638509342960791981e-01, 6.268570181766053295e-01, 5.195136536074571598e-01],
        [2.660910828965943331e-01, 6.304405546707460006e-01, 5.184861377534477622e-01],
        [2.683698467163787016e-01, 6.340264147511259774e-01, 5.174130230514244477e-01],
        [2.706903509949471487e-01, 6.376141889650659422e-01, 5.162935692788781505e-01],
        [2.730554221838172868e-01, 6.412035896296301996e-01, 5.151259285643695618e-01],
        [2.754676310512871873e-01, 6.447944545228798674e-01, 5.139069764892589820e-01],
        [2.779309010023177096e-01, 6.483859905965968506e-01, 5.126390269795514376e-01],
        [2.804483318408275694e-01, 6.519777450281342146e-01, 5.113214639163841113e-01],
        [2.830229969716622218e-01, 6.555692556652558123e-01, 5.099537040511894492e-01],
        [2.856569925022096612e-01, 6.591606030439277619e-01, 5.085297306531970651e-01],
        [2.883543502639873135e-01, 6.627507929293073863e-01, 5.070537569679475220e-01],
        [2.911180907975667309e-01, 6.663393219020087299e-01, 5.055253556302098383e-01],
        [2.939511790083492726e-01, 6.699256847308838747e-01, 5.039440536705714901e-01],
        [2.968562131418951422e-01, 6.735096490751359966e-01, 5.023062065413991251e-01],
        [2.998362114418811064e-01, 6.770906951012128916e-01, 5.006109626120457401e-01],
        [3.028943961763405635e-01, 6.806680059292820051e-01, 4.988609220555944579e-01],
        [3.060335830069556007e-01, 6.842410278074210206e-01, 4.970557164988521071e-01],
        [3.092565373453909361e-01, 6.878091952372648032e-01, 4.951950035800954386e-01],
        [3.125659486948474952e-01, 6.913723055472413836e-01, 4.932732004330610542e-01],
        [3.159647522698377231e-01, 6.949295261702347348e-01, 4.912927476409480465e-01],
        [3.194556489243873809e-01, 6.984800979280558764e-01, 4.892553378582480961e-01],
        [3.230412442793148542e-01, 7.020233920397538352e-01, 4.871607422199746851e-01],
        [3.267240985578743762e-01, 7.055587631720373620e-01, 4.850087606010107799e-01],
        [3.305070751488592418e-01, 7.090857414439620809e-01, 4.827955626459811689e-01],
        [3.343929739199408280e-01, 7.126036449951604901e-01, 4.805201317683439055e-01],
        [3.383839618515475101e-01, 7.161115318028217214e-01, 4.781864627637871235e-01],
        [3.424824761777380822e-01, 7.196086676710338192e-01, 4.757945201032026117e-01],
        [3.466909265050957534e-01, 7.230942938245445983e-01, 4.733443136156250675e-01],
        [3.510117003671430203e-01, 7.265676248366644829e-01, 4.708359034900377327e-01],
        [3.554477481971078934e-01, 7.300279237012574640e-01, 4.682667163182038794e-01],
        [3.600022066505755847e-01, 7.334743741555846963e-01, 4.656343331651458528e-01],
        [3.646764457841936702e-01, 7.369059239634064840e-01, 4.629441295765394648e-01],
        [3.694728210602395979e-01, 7.403216514270205550e-01, 4.601965063235068931e-01],
        [3.743936915522128039e-01, 7.437205957454258165e-01, 4.573919681273960758e-01],
        [3.794414259131371203e-01, 7.471017539541063845e-01, 4.545311394783269621e-01],
        [3.846184079557829483e-01, 7.504640777072076885e-01, 4.516147832933739559e-01],
        [3.899270416022538321e-01, 7.538064699246833644e-01, 4.486438228496626990e-01],
        [3.953697549145612777e-01, 7.571277813375660859e-01, 4.456193674826627871e-01],
        [4.009508646485598904e-01, 7.604267477869489644e-01, 4.425380639654961090e-01],
        [4.066714019599443342e-01, 7.637021069222051928e-01, 4.394056497009877216e-01],
        [4.125334807152798988e-01, 7.669525443587899005e-01, 4.362249727525224774e-01],
        [4.185395667527040398e-01, 7.701766751192415938e-01, 4.329983295596441795e-01],
        [4.246921350385852723e-01, 7.733730477083216037e-01, 4.297284080553480656e-01],
        [4.309936593663836191e-01, 7.765401418648604226e-01, 4.264183470604332449e-01],
        [4.374465975304094312e-01, 7.796763669997491819e-01, 4.230718037095967943e-01],
        [4.440533711015541840e-01, 7.827800615723168320e-01, 4.196930295353452078e-01],
        [4.508163388346139722e-01, 7.858494937119429036e-01, 4.162869557148224930e-01],
        [4.577377626480225170e-01, 7.888828634531382944e-01, 4.128592877810690620e-01],
        [4.648197650471433406e-01, 7.918783070193569085e-01, 4.094166097874233912e-01],
        [4.720642768256655963e-01, 7.948339036614172626e-01, 4.059664974607166132e-01],
        [4.794729738954752185e-01, 7.977476856267914362e-01, 4.025176392507668344e-01],
        [4.870472021865835388e-01, 8.006176519006481529e-01, 3.990799633442549399e-01],
        [4.947878897554374711e-01, 8.034417864099652196e-01, 3.956647676266520364e-01],
        [5.026954455748450235e-01, 8.062180814071850943e-01, 3.922848482216537147e-01],
        [5.107722312752203120e-01, 8.089441566688712060e-01, 3.889513459863399025e-01],
        [5.190175807229889804e-01, 8.116180108735555621e-01, 3.856804341377490508e-01],
        [5.274270476594079549e-01, 8.142382455983395717e-01, 3.824934902796895964e-01],
        [5.359974387485314518e-01, 8.168032862890818313e-01, 3.794106529717772847e-01],
        [5.447242959015131669e-01, 8.193118012377970105e-01, 3.764539238160731771e-01],
        [5.536017493685388979e-01, 8.217627673204914718e-01, 3.736470734604069865e-01],
        [5.626223858732353200e-01, 8.241555398979113489e-01, 3.710154595070918049e-01],
        [5.717801732913297963e-01, 8.264893011624766528e-01, 3.685830453573430421e-01],
        [5.810619798273547465e-01, 8.287648131945639651e-01, 3.663798607459672341e-01],
        [5.904522695833789303e-01, 8.309836316507100973e-01, 3.644363382969363352e-01],
        [5.999363056699199559e-01, 8.331474672067843423e-01, 3.627802030453921023e-01],
        [6.094978370184862548e-01, 8.352587020450518152e-01, 3.614380620192426119e-01],
        [6.191178753985615568e-01, 8.373207419267220120e-01, 3.604354982890065617e-01],
        [6.287753075069072439e-01, 8.393379672623436649e-01, 3.597956834322972863e-01],
        [6.384515865712356852e-01, 8.413146218129586851e-01, 3.595361765343614291e-01],
        [6.481275660781142811e-01, 8.432555569199260415e-01, 3.596707668706327632e-01],
        [6.577845458065525452e-01, 8.451659780810962808e-01, 3.602086612732601778e-01],
        [6.674047070379289792e-01, 8.470513147981415525e-01, 3.611542742755425861e-01],
        [6.769617561788032756e-01, 8.489198363378159806e-01, 3.625096347273936148e-01],
        [6.864487597795673191e-01, 8.507748949282539774e-01, 3.642665641101618390e-01],
        [6.958544314564799604e-01, 8.526212799355240568e-01, 3.664154684319869681e-01],
        [7.051685608468114541e-01, 8.544637256207057163e-01, 3.689436786046771388e-01],
        [7.143830272263600456e-01, 8.563065614925247093e-01, 3.718358172740615641e-01],
        [7.234917624309317175e-01, 8.581536540348341235e-01, 3.750744951817871486e-01],
        [7.324906484647774052e-01, 8.600083717860309562e-01, 3.786409937540124448e-01],
        [7.413773645706981386e-01, 8.618735721244006331e-01, 3.825158976261986421e-01],
        [7.501511992657796668e-01, 8.637516069265696039e-01, 3.866796514151401021e-01],
        [7.588128421172509741e-01, 8.656443435632366068e-01, 3.911130257986148440e-01],
        [7.673641682613402404e-01, 8.675531974405399360e-01, 3.957974875667232828e-01],
        [7.758080262912036007e-01, 8.694791724028596569e-01, 4.007154759905482422e-01],
        [7.841480375461038488e-01, 8.714229056785223193e-01, 4.058505933213660266e-01],
        [7.923777293356836227e-01, 8.733886508286130557e-01, 4.111824877427081026e-01],
        [8.004976303968860396e-01, 8.753781889640523950e-01, 4.166935560611597644e-01],
        [8.085242857272323391e-01, 8.773871783186646400e-01, 4.223760515178233144e-01],
        [8.164630734789560806e-01, 8.794151844938148388e-01, 4.282186311869483064e-01],
        [8.243194501554683695e-01, 8.814616081475756815e-01, 4.342112747863317024e-01],
        [8.320860387263339097e-01, 8.835308362945183402e-01, 4.403358497380424619e-01],
        [8.397544323444476877e-01, 8.856278479633188372e-01, 4.465723185371322512e-01],
        [8.473543986252204396e-01, 8.877421380157632935e-01, 4.529306634208433713e-01],
        [8.548913210362114601e-01, 8.898726582646793171e-01, 4.594053245849991085e-01],
        [8.623409541601502193e-01, 8.920307544658760968e-01, 4.659650403812060637e-01],
        [8.697191661117472661e-01, 8.942111604773197442e-01, 4.726125804953009157e-01],
        [8.770479480763140323e-01, 8.964055876253053112e-01, 4.793596015320920611e-01],
        [8.843061388708378656e-01, 8.986242192828276520e-01, 4.861771826919926709e-01],
        [8.914967901846199139e-01, 9.008669432468144889e-01, 4.930589607663434237e-01],
        [8.986506618699680038e-01, 9.031210853874221955e-01, 5.000298200873778409e-01],
        [9.057328617844134788e-01, 9.054032588350297006e-01, 5.070444917818385244e-01],
        [9.127681739145864226e-01, 9.077032841253237505e-01, 5.141229319104883011e-01],
        [9.197719823668246697e-01, 9.100148294768658497e-01, 5.212774789419143406e-01],
        [9.266999503758117651e-01, 9.123594905222979223e-01, 5.284479861571415027e-01],
        [9.336093927737403320e-01, 9.147111822755604749e-01, 5.356989519972219504e-01],
        [9.404610328906413130e-01, 9.170893351552455997e-01, 5.429753047678268496e-01],
        [9.472803518326599059e-01, 9.194825361628593541e-01, 5.503044468166357062e-01],
        [9.540659681238262690e-01, 9.218921210725944393e-01, 5.576799909240343078e-01],
        [9.608049809199471492e-01, 9.243252266483533708e-01, 5.650790057480892248e-01],
        [9.675287370768704820e-01, 9.267668902399696096e-01, 5.725413863443260531e-01],
        [9.741967269037244970e-01, 9.292382142036349491e-01, 5.800041593344547053e-01],
        [9.808627042040826138e-01, 9.317124815536732552e-01, 5.875425838151492330e-01],
        [9.874684104099172854e-01, 9.342202886448683907e-01, 5.950648878797101249e-01],
        [9.940805805099582892e-01, 9.367275819156850591e-01, 6.026699962989522374e-01]];

% Interpolate to requested number of colors.

P = size(cmap,1);

if (P ~= M)
  cmap = interp1(1:size(cmap,1), cmap, linspace(1,P,M), 'linear');
end

return