//
//  ImagePicker.swift
//  Sluv2
//
//  Created by 장윤정 on 2024/02/24.
//

import Foundation
import YPImagePicker
import UIKit
import Photos

extension WebviewVC {
    @objc func loadImagePicker() {
        
        var config = YPImagePickerConfiguration()

        
        config.screens = [.library]
        config.startOnScreen = .library // 첫 시작시 앨범이 default
        config.shouldSaveNewPicturesToAlbum = false // YPImagePicker의 카메라로 찍은 사진 핸드폰에 저장안함
        config.showsPhotoFilters = false // 이미지 필터 사용하지 않기
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        
        config.library.defaultMultipleSelection = false // 한장 선택 default (여러장 선택x)
        config.library.maxNumberOfItems = 5 // 사진 최대 선택 개수 5장
        config.library.mediaType = .photo // 옵션 : photo, video, photo and video
        config.library.preselectedItems = selectedImage // 사진 선택후 뒤로 갔을때 초기화 되지 않기 위함
        config.overlayView?.contentMode = .scaleAspectFit // 사진 스케일

        let picker = YPImagePicker(configuration: config)
        
        // 사진 선택 완료후,,
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                // 취소 눌렀을때
                picker.dismiss(animated: true)
            } else {
                // 사진 선택후
                for item in items {
                    switch item {
                    case .photo(let photo):
                        let image: UIImage = photo.image // UIImage
                        let metadata: PHAsset? = photo.asset // 사진 메타 데이터
                        let isCamera: Bool = photo.fromCamera // 카메라로 찍은 사진인지 여부

                        if isCamera {
                            // 카메라인 경우
                            // code...
                            // 이경우에 메타데이터는 nil이다.
                            // 카메라로 찍은 사진도 메타데이터를 생성해서 핸드폰에 저장해주면 좋겠지만, 지원하지 않는것 같다.
                        } else {
                            // 갤러리인 경우
                            print("위도: \(String(describing: metadata?.location?.coordinate.latitude))")
                            print("경도: \(String(describing: metadata?.location?.coordinate.longitude))")
                            print("시간: \(String(describing: metadata?.location?.timestamp))")
                        }
                    default:
                        break
                    }
                }

                // 선택한 아이템들 (뒤로갔을때 선택이 남아있게끔하기 위함)
                // 타입 : [YPMediaItem]
                self.selectedImage = items
                
                // 이미지 피커뷰 닫기
                picker.dismiss(animated: false)
            }
        }
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "black") ] // Title color
        
        // 이미지 피커뷰 열기
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)

    }
}
