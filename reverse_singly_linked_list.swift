//
//  A. Achimescu
//  assign_2_6_reverseSinglyLinkedList.playground
//
//
//  This program will create a singly linked list and then reverse it
//

import Foundation

// only give restrictions when the user first says how long they want their linked list to be!
// then, it will become true and the int inputted will no longer HAVE to be greater than 0
var input:Bool = false

// making the node class
class node {
    var value: Int? = nil
    var next: node? = nil
}

// making the linked list class
class linkedList {
    var head:node?
    var current:node?
    
    // insert a new value into the linked list
    func insert(_ value: Int) {
        // is this an empty list
        if self.head == nil { // empty list
            self.head = node()
            self.head!.value = value
            self.current = self.head
        } else {
            let newNode = node()
            newNode.next = self.current?.next
            self.current?.next = newNode
            newNode.value = value
            self.current = newNode
        }
    }
    
    // remove the first value of the linked list
    func removeFirst() {
        // empty list, nothing to do
        if self.current == nil {
            print("Empty list, cannot remove nodes")
            return
        } else { //
            if self.current === self.head { // if current is the head, then advance current
                self.current = self.head!.next
            } // if current is not the head, then leave it alone, since it is not affected.
            
            if let tempNode = self.head!.next {
                self.head = tempNode
            } else {
                self.head = nil
            }
        }
    }
    
    // find the node at a given value
    func nodeAt(_ index:Int) -> node? {
        if index >= 0 {
            var node = head
            var i = index
            
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    // print all the values in the linked list
    func printAllKeys() {
        var tempNode:node? = self.head
        
        while tempNode != nil && tempNode!.value != nil {
            print(tempNode!.value!)
            tempNode = tempNode!.next
        }
    }
    
    // reverse the linked list by finding the values from before (its recursive !)
    func reverse (_ num2:Int){
        let num:Int = nodeAt(num2 - 1)!.value!
        insert(num)
        
        if num2 != 1 {
            reverse(num2 - 1)
        }
    }
}

// Get a positive integer from the user
func getInteger() -> Int {
    var value:Int = 0
    while true {
        // get value from user. Using optional input since readLine returns an optional string.
        guard let inputLine = readLine() else {
            fatalError("Unexpected end-of-file condition")
        }
        
        // attempt to convert the input string to an Int
        if let unwrappedInt = Int(inputLine) {
            if unwrappedInt > 0 || input == true {
                value = unwrappedInt
                break
            } else {
                print("`\(inputLine)` is not greater than 0. Please enter an integer")
            }
        }
            // the input doesn't convert into an int
        else {
            print("`\(inputLine)` is not an integer. Please enter an integer")
        }
    }
    return value
}

var myList = linkedList()
var someNode:node?

// ask the user for the number of items in the linked list
print("Hello! Please enter how many numbers you would like there to be in your singly linked list")
var num:Int = getInteger()

print("If you want to fill up the linked list yourself, please enter 0.")
print("Otherwise, please hit any key.")
var random:String = readLine()!
var numInsert:Int = 0

// ask the user to fill up the linked list

if random == "0" {
    print("Please insert", num, "numbers with enters in between")
    input = true
    
    for _ in 1...num {
        numInsert = getInteger()
        myList.insert(numInsert)
    }
} else {
    for _ in 1...num {
        numInsert = Int(arc4random())
        myList.insert(numInsert)
    }
}

print("These are the following numbers in the current linked list:")
myList.printAllKeys()

// reverse linked list
myList.reverse(num)

// remove all numbers from beginning
for _ in 1...num {
    myList.removeFirst()
    
}
print("These are the following numbers in the newly reversed linked list:")
myList.printAllKeys()

/* TEST 1
 Hello! Please enter how many numbers you would like there to be in your singly linked list
 10
 Please insert 10  numbers with enters in between
 4
 5
 6
 7
 9
 10
 3
 34342
 2
 3
 These are the following numbers in the current linked list:
 4
 5
 6
 7
 9
 10
 3
 34342
 2
 3
 These are the following numbers in the newly reversed linked list:
 3
 2
 34342
 3
 10
 9
 7
 6
 5
 4
 Program ended with exit code: 0 */

/* TEST 2
 Hello! Please enter how many numbers you would like there to be in your singly linked list
 -0
 `-0` is not greater than 0. Please enter an integer
 -8
 `-8` is not greater than 0. Please enter an integer
 eight
 `eight` is not an integer. Please enter an integer
 8
 Please insert 8 numbers with enters in between
 0
 -9
 5
 n
 `n` is not an integer. Please enter an integer
 5
 -0
 23
 234567n
 `234567n` is not an integer. Please enter an integer
 65432
 7
 These are the following numbers in the current linked list:
 0
 -9
 5
 5
 0
 23
 65432
 7
 These are the following numbers in the newly reversed linked list:
 7
 65432
 23
 0
 5
 5
 -9
 0
 Program ended with exit code: 0 */

/* TEST 3
 Hello! Please enter how many numbers you would like there to be in your singly linked list
 40
 If you want to fill up the linked list yourself, please enter 0.
 Otherwise, please hit any key.
 h
 These are the following numbers in the current linked list:
 4046414975
 999358153
 90108845
 3158026827
 3585348989
 2687597072
 2363933390
 2977356856
 1426752033
 1167160195
 4032411628
 200569845
 724785991
 132716852
 2275635
 3499565146
 1072316951
 2830252985
 1407932089
 2142977200
 717312611
 666342399
 871390293
 885811508
 1143717775
 3004349524
 2205384898
 1986665684
 4138881003
 1025811194
 4029132642
 2339609766
 3440288242
 894830508
 779324947
 1531168279
 354542852
 2225218273
 3272400194
 1784252994
 These are the following numbers in the newly reversed linked list:
 1784252994
 3272400194
 2225218273
 354542852
 1531168279
 779324947
 894830508
 3440288242
 2339609766
 4029132642
 1025811194
 4138881003
 1986665684
 2205384898
 3004349524
 1143717775
 885811508
 871390293
 666342399
 717312611
 2142977200
 1407932089
 2830252985
 1072316951
 3499565146
 2275635
 132716852
 724785991
 200569845
 4032411628
 1167160195
 1426752033
 2977356856
 2363933390
 2687597072
 3585348989
 3158026827
 90108845
 999358153
 4046414975
 Program ended with exit code: 0 */

/* TEST 4
 Hello! Please enter how many numbers you would like there to be in your singly linked list
 -00
 `-00` is not greater than 0. Please enter an integer
 -100
 `-100` is not greater than 0. Please enter an integer
 900
 If you want to fill up the linked list yourself, please enter 0.
 Otherwise, please hit any key.
 i
 These are the following numbers in the current linked list:
 1739265957
 1670352792
 131264908
 1304920879
 2295821875
 1253379223
 1131206035
 268846272
 1810949634
 1896937905
 1822206158
 2690989688
 1292647094
 2809916112
 4036687128
 3404929829
 1765309455
 316129352
 3170062120
 3254495568
 2624996637
 781103729
 164227780
 565880297
 1871028269
 3516659285
 902083866
 3645342924
 921498624
 3284710452
 186404011
 324962680
 259913604
 139348811
 2797704620
 1297300944
 511989264
 492140750
 3916693212
 2563392871
 1439022545
 2626437145
 158218764
 380805439
 168470798
 3950470427
 3470802117
 2305473548
 4232515727
 1894007894
 2642354567
 1575950528
 2997068557
 3961113312
 2880065845
 727345676
 4033490408
 520526832
 2970403278
 3253361010
 296122396
 3930352281
 1546933370
 2827778967
 1013174546
 2783253810
 2509031461
 993400876
 1844351158
 1636632199
 760448279
 435235345
 3878051400
 4173125347
 1457829141
 2491733301
 2611610798
 594785696
 3674757653
 3407162034
 4058178097
 2811436049
 3997389447
 1170504787
 3750423990
 4160406211
 1300145593
 839947978
 271849985
 858601560
 3715813357
 2578700235
 2415032141
 1839219431
 915667189
 3147135306
 3532184518
 646404422
 958336936
 2024118066
 3696404585
 3381248449
 2467496002
 3284174159
 3541215596
 2106958169
 2295352113
 909433624
 784249129
 1682196002
 4211251215
 950360142
 748507547
 3695564757
 724939652
 3442690357
 1767891561
 473687857
 941865217
 1455271675
 2898861296
 2899477479
 814651279
 1914853838
 358759815
 2191272764
 776854091
 22045321
 1555666483
 428648382
 129906802
 3410130307
 4254302790
 3434869003
 3947396539
 1733048637
 378417891
 3730627382
 3804426304
 4041886211
 1082452168
 399977195
 1910535871
 664966377
 654567755
 1572046149
 493368640
 1806634311
 5865939
 2814740734
 3687899361
 2362407426
 3842565889
 2984532925
 494565205
 2739963974
 3588829510
 2685813485
 4228235831
 785559177
 3123165463
 3963845546
 2766545386
 1271478370
 3546761647
 2465484889
 3555413649
 3103350491
 3624407885
 2462126031
 690289804
 4243257279
 2877451743
 3071137902
 1720352409
 48720844
 254360304
 3632844417
 811429211
 3449562346
 4128999772
 590615719
 349354941
 1928013201
 122788380
 169372584
 1334774191
 4118786528
 793235832
 4017625372
 1214984275
 269287173
 2111461075
 3923659522
 1672796308
 1567903234
 1189409199
 1600525957
 2014225737
 529895042
 933525667
 2014159839
 1764642411
 4154411166
 1815945042
 1289207418
 2778802198
 3231587838
 685605588
 3432531312
 1822577643
 3926400119
 2800376722
 4054195257
 1628711128
 2776620968
 3906285509
 2146549497
 1383039623
 2196322342
 2157070795
 1097416705
 4101342328
 2381620646
 199554592
 2591687798
 2991737264
 4245452591
 2661431848
 871608977
 2684582629
 3219233114
 2302470423
 3114667096
 3779294346
 10904310
 1638363143
 3582028805
 3450838082
 394166212
 4033855502
 3007810594
 2321069884
 3388948753
 3699216620
 1390192661
 3294227448
 2504715288
 927526679
 1632556731
 2595886329
 791509845
 3614021673
 1568563293
 3174092872
 1500911786
 453936567
 2106273866
 1901273107
 1247962253
 1633510483
 2005452233
 2631742100
 1010706115
 3072735841
 2109008783
 208308895
 524348725
 1605923270
 2199804249
 800407817
 1373964960
 3590805614
 1548606689
 3335230641
 1334238240
 530540631
 3631035375
 1008752013
 470659684
 3398701251
 841617900
 3294565963
 57369839
 116909783
 3972624971
 2341719093
 2830546787
 2956939130
 735360129
 1974195907
 795025835
 1318461678
 2043667328
 3490850317
 4227783348
 1392358441
 1356360767
 758302783
 1457238553
 1758987076
 1727025571
 1446368431
 3683324910
 1312471824
 1484074203
 261522049
 1141831520
 2971831081
 3117536213
 3413014772
 2569246018
 3623934833
 4116214016
 3224677421
 151935313
 2119346166
 4268996471
 2597676841
 1416833111
 1377149365
 2287552304
 208966560
 4120849432
 1142360103
 2468210058
 4000338388
 1121432534
 3018269868
 941927645
 837812733
 2715535147
 3061049858
 3733610085
 3750328758
 849271907
 1035368018
 2990865601
 4064640171
 4090964212
 1645286683
 2885007085
 1437742702
 3239656876
 1888787603
 3289498901
 3481016099
 248683632
 1455432128
 4018918306
 2503744723
 939894604
 52064031
 3524849613
 2740121425
 403033158
 2442213904
 535897357
 2965660830
 1629383317
 230997648
 309692346
 3387202309
 2628535183
 196362581
 266167062
 520429999
 3713858281
 40601503
 4206793586
 1130113837
 1064891498
 945641256
 2231160051
 1463752349
 3186690375
 4275609048
 4165396537
 3054004857
 728535241
 2821349639
 3165417926
 1807563169
 2586256118
 1629008344
 3488423934
 4098680769
 729076893
 3566038747
 1664132145
 2745083925
 2337428376
 3742384180
 2933351891
 3266110187
 90952932
 2927931733
 3458963643
 1954873078
 3375846082
 3590740104
 2620593495
 2472181905
 2990959312
 4230324795
 1681737099
 4191493790
 364158089
 1246392652
 805886499
 1308525455
 2282521388
 2860814707
 1905860853
 4126473601
 2887205647
 142498667
 2804571199
 3867125469
 1140531379
 4233954987
 4125890802
 1857154505
 4128892950
 2718816161
 3057568379
 2712276249
 3278830359
 1762741670
 2622424473
 1075553041
 3932954326
 821462394
 2678085514
 114435820
 870290826
 707549686
 3557701833
 10707251
 4042763449
 3820046713
 1067212853
 1323975974
 3498695977
 595748180
 2000940717
 2272911616
 404607367
 2464087172
 1001231899
 1561987375
 3901880267
 4228766008
 679537599
 2977837907
 810452766
 183697716
 619639030
 1841418651
 813922420
 473964503
 1030030912
 979234992
 598223830
 941880338
 840402310
 3083799541
 3363361831
 3920023051
 2751089328
 2521261461
 2447089113
 1562948713
 2905274458
 4187019153
 44147098
 3073499559
 1405779556
 2464549052
 88040949
 1484910220
 2565403228
 1271226031
 2452061015
 2083452474
 3920424129
 3640136748
 1991764214
 282591228
 4166305109
 1254428714
 2433324097
 773086179
 3472769955
 2849899529
 2767201266
 305166868
 2247329434
 646631135
 2208543524
 78010436
 3732595650
 1752307066
 3695718288
 3453771047
 2833897450
 686263988
 2862927730
 235955584
 223251723
 3771290984
 1910809191
 2967890469
 339165881
 3928546843
 1912017062
 1223797381
 2880405181
 2690539767
 909800752
 3592540166
 1577268438
 4220673076
 2451383272
 1116287613
 3455814092
 1636074787
 2232244852
 407193818
 165262946
 1156762401
 1101917341
 1666204233
 2724493707
 235400922
 372544162
 3800444212
 2999047816
 245562592
 254156198
 873073844
 1594794965
 3751386728
 799360662
 8042076
 3865544571
 1275157888
 2701548210
 3969087867
 1473619459
 277762617
 2372319552
 2879949629
 3934390205
 223597855
 2969459265
 895097768
 1962794664
 2621383633
 3456915512
 1209070798
 1556076083
 4133974864
 3440210745
 355033008
 1985642965
 4217976851
 4071433504
 1402623083
 2208759815
 859420255
 3096299117
 3307806897
 1905886723
 1697902802
 1228548109
 3945668231
 4274863790
 2444510402
 4023890892
 644905143
 1067841928
 1900031377
 213217640
 1515900243
 724225956
 2761266045
 923831399
 1546786983
 3465324195
 3273977966
 2211999122
 895953862
 3503227544
 3048034095
 1745882172
 4279831436
 84209294
 1637744786
 2285985677
 2124375373
 212838677
 3770585579
 2752451391
 864096284
 1615736461
 4093521477
 514789239
 2237422114
 3632294181
 3948264758
 2066763794
 821409169
 839486759
 2492874300
 1460503978
 3042798999
 1970672365
 4277270952
 1779074664
 1730475402
 961361405
 2118275152
 972016670
 64143696
 2081148666
 372274571
 2333411001
 1178834708
 1083796440
 193510025
 4179622259
 456908487
 1739178902
 57827184
 3418922684
 3316064444
 1016637589
 3393321712
 1963235357
 3116204993
 504692783
 1529791611
 1044116962
 80865336
 2027291969
 1896025589
 1171298617
 2404272081
 1505705676
 921313820
 3438792389
 377444063
 2848037140
 1473045369
 402620170
 1761694398
 789135938
 3866848658
 3370572555
 4131289456
 402949708
 2421802599
 730197436
 1956035084
 1389001948
 1379683040
 931319324
 3686325286
 1628341501
 2845354773
 3230256706
 1091728361
 561073944
 514991274
 2713270742
 4256405550
 2791127322
 861716538
 2054102229
 2977705561
 3804204878
 1199372883
 2920711047
 2273908663
 2514526924
 393579205
 317618738
 2120667318
 1237288426
 1883587389
 3222644591
 3831440605
 3563062941
 935369838
 3440193281
 2829270901
 1713989124
 700993691
 4174028094
 242397287
 1124915963
 2372922882
 1023132320
 816873712
 4278048569
 399541592
 2546248705
 402798941
 18676953
 2070586722
 2174091873
 419191962
 1481093660
 2894189109
 1906363349
 1059968486
 2987735958
 3503479842
 671034594
 3931209076
 2756606019
 2692318788
 138268560
 750299450
 4174913227
 2781494992
 1281374886
 2692697729
 3309352693
 3764740995
 2896987000
 192544941
 401147487
 4116357799
 3779023268
 1107332279
 1238619561
 650787926
 415845568
 860908078
 3294311518
 4273423262
 57583283
 3996199443
 3272643968
 1709828228
 589887953
 201293055
 939228046
 2865983955
 2857535013
 3422786382
 4262765970
 2424744998
 4280511329
 2605176463
 2006086072
 751496159
 2300442664
 498623959
 2909843460
 10566928
 84938801
 2580671470
 2460587484
 3050100623
 848506532
 1235650028
 701257493
 865680622
 253518182
 2038748785
 1728662329
 1289282944
 3324813234
 835755128
 56625579
 1045109649
 1891768847
 419361451
 1639134270
 933558822
 2594282326
 3777085852
 3805894199
 2703243926
 3206011704
 3722405042
 2224499848
 2879569658
 580797553
 4110448847
 3898410291
 1021615289
 3934402304
 1535024444
 237565812
 2252531632
 3854973398
 2229503252
 1853693938
 3227669975
 420795877
 2013613673
 2371059235
 4162065317
 2165656068
 63165413
 1135961833
 1247795610
 1725033358
 640907150
 905894151
 2993243612
 2218507867
 2744035573
 207739053
 3976020730
 2795419764
 833362751
 472438856
 435389985
 2295544447
 2142635760
 2054578309
 603607873
 2566296526
 2321442774
 106189853
 3146227712
 2137515248
 1548932306
 2773915575
 3084423063
 1090204570
 1947004623
 601301111
 3004192854
 2020228176
 1372128327
 3461731141
 1159272864
 701817831
 2573870961
 1512791252
 1960147170
 3661352408
 1028569865
 3623936966
 662746070
 2214072178
 2100350594
 26541138
 3227419669
 472910860
 3946769774
 1245995875
 2430933912
 1319345318
 2077490371
 2387530612
 2282035551
 314224189
 2673339110
 3112753988
 3167765869
 1565847939
 57101929
 656663334
 3516157222
 597923365
 1504163224
 97517188
 3457672906
 864895216
 1285353760
 1042587473
 3699999679
 3034825841
 3734951574
 2242269908
 3062960602
 1355003526
 295712941
 735435663
 2568545173
 230497145
 2812093235
 328045055
 2025586117
 3050568437
 3540463537
 4129491818
 1328054468
 726280579
 2523672598
 2358410421
 756195881
 3135387613
 These are the following numbers in the newly reversed linked list:
 3135387613
 756195881
 2358410421
 2523672598
 726280579
 1328054468
 4129491818
 3540463537
 3050568437
 2025586117
 328045055
 2812093235
 230497145
 2568545173
 735435663
 295712941
 1355003526
 3062960602
 2242269908
 3734951574
 3034825841
 3699999679
 1042587473
 1285353760
 864895216
 3457672906
 97517188
 1504163224
 597923365
 3516157222
 656663334
 57101929
 1565847939
 3167765869
 3112753988
 2673339110
 314224189
 2282035551
 2387530612
 2077490371
 1319345318
 2430933912
 1245995875
 3946769774
 472910860
 3227419669
 26541138
 2100350594
 2214072178
 662746070
 3623936966
 1028569865
 3661352408
 1960147170
 1512791252
 2573870961
 701817831
 1159272864
 3461731141
 1372128327
 2020228176
 3004192854
 601301111
 1947004623
 1090204570
 3084423063
 2773915575
 1548932306
 2137515248
 3146227712
 106189853
 2321442774
 2566296526
 603607873
 2054578309
 2142635760
 2295544447
 435389985
 472438856
 833362751
 2795419764
 3976020730
 207739053
 2744035573
 2218507867
 2993243612
 905894151
 640907150
 1725033358
 1247795610
 1135961833
 63165413
 2165656068
 4162065317
 2371059235
 2013613673
 420795877
 3227669975
 1853693938
 2229503252
 3854973398
 2252531632
 237565812
 1535024444
 3934402304
 1021615289
 3898410291
 4110448847
 580797553
 2879569658
 2224499848
 3722405042
 3206011704
 2703243926
 3805894199
 3777085852
 2594282326
 933558822
 1639134270
 419361451
 1891768847
 1045109649
 56625579
 835755128
 3324813234
 1289282944
 1728662329
 2038748785
 253518182
 865680622
 701257493
 1235650028
 848506532
 3050100623
 2460587484
 2580671470
 84938801
 10566928
 2909843460
 498623959
 2300442664
 751496159
 2006086072
 2605176463
 4280511329
 2424744998
 4262765970
 3422786382
 2857535013
 2865983955
 939228046
 201293055
 589887953
 1709828228
 3272643968
 3996199443
 57583283
 4273423262
 3294311518
 860908078
 415845568
 650787926
 1238619561
 1107332279
 3779023268
 4116357799
 401147487
 192544941
 2896987000
 3764740995
 3309352693
 2692697729
 1281374886
 2781494992
 4174913227
 750299450
 138268560
 2692318788
 2756606019
 3931209076
 671034594
 3503479842
 2987735958
 1059968486
 1906363349
 2894189109
 1481093660
 419191962
 2174091873
 2070586722
 18676953
 402798941
 2546248705
 399541592
 4278048569
 816873712
 1023132320
 2372922882
 1124915963
 242397287
 4174028094
 700993691
 1713989124
 2829270901
 3440193281
 935369838
 3563062941
 3831440605
 3222644591
 1883587389
 1237288426
 2120667318
 317618738
 393579205
 2514526924
 2273908663
 2920711047
 1199372883
 3804204878
 2977705561
 2054102229
 861716538
 2791127322
 4256405550
 2713270742
 514991274
 561073944
 1091728361
 3230256706
 2845354773
 1628341501
 3686325286
 931319324
 1379683040
 1389001948
 1956035084
 730197436
 2421802599
 402949708
 4131289456
 3370572555
 3866848658
 789135938
 1761694398
 402620170
 1473045369
 2848037140
 377444063
 3438792389
 921313820
 1505705676
 2404272081
 1171298617
 1896025589
 2027291969
 80865336
 1044116962
 1529791611
 504692783
 3116204993
 1963235357
 3393321712
 1016637589
 3316064444
 3418922684
 57827184
 1739178902
 456908487
 4179622259
 193510025
 1083796440
 1178834708
 2333411001
 372274571
 2081148666
 64143696
 972016670
 2118275152
 961361405
 1730475402
 1779074664
 4277270952
 1970672365
 3042798999
 1460503978
 2492874300
 839486759
 821409169
 2066763794
 3948264758
 3632294181
 2237422114
 514789239
 4093521477
 1615736461
 864096284
 2752451391
 3770585579
 212838677
 2124375373
 2285985677
 1637744786
 84209294
 4279831436
 1745882172
 3048034095
 3503227544
 895953862
 2211999122
 3273977966
 3465324195
 1546786983
 923831399
 2761266045
 724225956
 1515900243
 213217640
 1900031377
 1067841928
 644905143
 4023890892
 2444510402
 4274863790
 3945668231
 1228548109
 1697902802
 1905886723
 3307806897
 3096299117
 859420255
 2208759815
 1402623083
 4071433504
 4217976851
 1985642965
 355033008
 3440210745
 4133974864
 1556076083
 1209070798
 3456915512
 2621383633
 1962794664
 895097768
 2969459265
 223597855
 3934390205
 2879949629
 2372319552
 277762617
 1473619459
 3969087867
 2701548210
 1275157888
 3865544571
 8042076
 799360662
 3751386728
 1594794965
 873073844
 254156198
 245562592
 2999047816
 3800444212
 372544162
 235400922
 2724493707
 1666204233
 1101917341
 1156762401
 165262946
 407193818
 2232244852
 1636074787
 3455814092
 1116287613
 2451383272
 4220673076
 1577268438
 3592540166
 909800752
 2690539767
 2880405181
 1223797381
 1912017062
 3928546843
 339165881
 2967890469
 1910809191
 3771290984
 223251723
 235955584
 2862927730
 686263988
 2833897450
 3453771047
 3695718288
 1752307066
 3732595650
 78010436
 2208543524
 646631135
 2247329434
 305166868
 2767201266
 2849899529
 3472769955
 773086179
 2433324097
 1254428714
 4166305109
 282591228
 1991764214
 3640136748
 3920424129
 2083452474
 2452061015
 1271226031
 2565403228
 1484910220
 88040949
 2464549052
 1405779556
 3073499559
 44147098
 4187019153
 2905274458
 1562948713
 2447089113
 2521261461
 2751089328
 3920023051
 3363361831
 3083799541
 840402310
 941880338
 598223830
 979234992
 1030030912
 473964503
 813922420
 1841418651
 619639030
 183697716
 810452766
 2977837907
 679537599
 4228766008
 3901880267
 1561987375
 1001231899
 2464087172
 404607367
 2272911616
 2000940717
 595748180
 3498695977
 1323975974
 1067212853
 3820046713
 4042763449
 10707251
 3557701833
 707549686
 870290826
 114435820
 2678085514
 821462394
 3932954326
 1075553041
 2622424473
 1762741670
 3278830359
 2712276249
 3057568379
 2718816161
 4128892950
 1857154505
 4125890802
 4233954987
 1140531379
 3867125469
 2804571199
 142498667
 2887205647
 4126473601
 1905860853
 2860814707
 2282521388
 1308525455
 805886499
 1246392652
 364158089
 4191493790
 1681737099
 4230324795
 2990959312
 2472181905
 2620593495
 3590740104
 3375846082
 1954873078
 3458963643
 2927931733
 90952932
 3266110187
 2933351891
 3742384180
 2337428376
 2745083925
 1664132145
 3566038747
 729076893
 4098680769
 3488423934
 1629008344
 2586256118
 1807563169
 3165417926
 2821349639
 728535241
 3054004857
 4165396537
 4275609048
 3186690375
 1463752349
 2231160051
 945641256
 1064891498
 1130113837
 4206793586
 40601503
 3713858281
 520429999
 266167062
 196362581
 2628535183
 3387202309
 309692346
 230997648
 1629383317
 2965660830
 535897357
 2442213904
 403033158
 2740121425
 3524849613
 52064031
 939894604
 2503744723
 4018918306
 1455432128
 248683632
 3481016099
 3289498901
 1888787603
 3239656876
 1437742702
 2885007085
 1645286683
 4090964212
 4064640171
 2990865601
 1035368018
 849271907
 3750328758
 3733610085
 3061049858
 2715535147
 837812733
 941927645
 3018269868
 1121432534
 4000338388
 2468210058
 1142360103
 4120849432
 208966560
 2287552304
 1377149365
 1416833111
 2597676841
 4268996471
 2119346166
 151935313
 3224677421
 4116214016
 3623934833
 2569246018
 3413014772
 3117536213
 2971831081
 1141831520
 261522049
 1484074203
 1312471824
 3683324910
 1446368431
 1727025571
 1758987076
 1457238553
 758302783
 1356360767
 1392358441
 4227783348
 3490850317
 2043667328
 1318461678
 795025835
 1974195907
 735360129
 2956939130
 2830546787
 2341719093
 3972624971
 116909783
 57369839
 3294565963
 841617900
 3398701251
 470659684
 1008752013
 3631035375
 530540631
 1334238240
 3335230641
 1548606689
 3590805614
 1373964960
 800407817
 2199804249
 1605923270
 524348725
 208308895
 2109008783
 3072735841
 1010706115
 2631742100
 2005452233
 1633510483
 1247962253
 1901273107
 2106273866
 453936567
 1500911786
 3174092872
 1568563293
 3614021673
 791509845
 2595886329
 1632556731
 927526679
 2504715288
 3294227448
 1390192661
 3699216620
 3388948753
 2321069884
 3007810594
 4033855502
 394166212
 3450838082
 3582028805
 1638363143
 10904310
 3779294346
 3114667096
 2302470423
 3219233114
 2684582629
 871608977
 2661431848
 4245452591
 2991737264
 2591687798
 199554592
 2381620646
 4101342328
 1097416705
 2157070795
 2196322342
 1383039623
 2146549497
 3906285509
 2776620968
 1628711128
 4054195257
 2800376722
 3926400119
 1822577643
 3432531312
 685605588
 3231587838
 2778802198
 1289207418
 1815945042
 4154411166
 1764642411
 2014159839
 933525667
 529895042
 2014225737
 1600525957
 1189409199
 1567903234
 1672796308
 3923659522
 2111461075
 269287173
 1214984275
 4017625372
 793235832
 4118786528
 1334774191
 169372584
 122788380
 1928013201
 349354941
 590615719
 4128999772
 3449562346
 811429211
 3632844417
 254360304
 48720844
 1720352409
 3071137902
 2877451743
 4243257279
 690289804
 2462126031
 3624407885
 3103350491
 3555413649
 2465484889
 3546761647
 1271478370
 2766545386
 3963845546
 3123165463
 785559177
 4228235831
 2685813485
 3588829510
 2739963974
 494565205
 2984532925
 3842565889
 2362407426
 3687899361
 2814740734
 5865939
 1806634311
 493368640
 1572046149
 654567755
 664966377
 1910535871
 399977195
 1082452168
 4041886211
 3804426304
 3730627382
 378417891
 1733048637
 3947396539
 3434869003
 4254302790
 3410130307
 129906802
 428648382
 1555666483
 22045321
 776854091
 2191272764
 358759815
 1914853838
 814651279
 2899477479
 2898861296
 1455271675
 941865217
 473687857
 1767891561
 3442690357
 724939652
 3695564757
 748507547
 950360142
 4211251215
 1682196002
 784249129
 909433624
 2295352113
 2106958169
 3541215596
 3284174159
 2467496002
 3381248449
 3696404585
 2024118066
 958336936
 646404422
 3532184518
 3147135306
 915667189
 1839219431
 2415032141
 2578700235
 3715813357
 858601560
 271849985
 839947978
 1300145593
 4160406211
 3750423990
 1170504787
 3997389447
 2811436049
 4058178097
 3407162034
 3674757653
 594785696
 2611610798
 2491733301
 1457829141
 4173125347
 3878051400
 435235345
 760448279
 1636632199
 1844351158
 993400876
 2509031461
 2783253810
 1013174546
 2827778967
 1546933370
 3930352281
 296122396
 3253361010
 2970403278
 520526832
 4033490408
 727345676
 2880065845
 3961113312
 2997068557
 1575950528
 2642354567
 1894007894
 4232515727
 2305473548
 3470802117
 3950470427
 168470798
 380805439
 158218764
 2626437145
 1439022545
 2563392871
 3916693212
 492140750
 511989264
 1297300944
 2797704620
 139348811
 259913604
 324962680
 186404011
 3284710452
 921498624
 3645342924
 902083866
 3516659285
 1871028269
 565880297
 164227780
 781103729
 2624996637
 3254495568
 3170062120
 316129352
 1765309455
 3404929829
 4036687128
 2809916112
 1292647094
 2690989688
 1822206158
 1896937905
 1810949634
 268846272
 1131206035
 1253379223
 2295821875
 1304920879
 131264908
 1670352792
 1739265957
 Program ended with exit code: 0 */

/* TEST 5
 Hello! Please enter how many numbers you would like there to be in your singly linked list
 4
 If you want to fill up the linked list yourself, please enter 0.
 Otherwise, please hit any key.
 
 These are the following numbers in the current linked list:
 2789346458
 1719256628
 2517156261
 2521285220
 These are the following numbers in the newly reversed linked list:
 2521285220
 2517156261
 1719256628
 2789346458
 Program ended with exit code: 0 */

