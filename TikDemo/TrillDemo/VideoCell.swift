//
//  VideoCell.swift
//  TrillDemo
//
//  Created by magic-devel on 2020/10/9.
//

import UIKit
import MarqueeLabel
import Kingfisher
import ChainableAnimations

class VideoCell: UITableViewCell {

    override func prepareForReuse() {
        // 重置关注按钮的所有动画状态
        if animator1 != nil {
            animator1.stop()
            addFollowBtn.transform = .identity
            addFollowBtn.layer.removeAllAnimations()
            addFollowBtn.setImage(UIImage(named: "icon_personal_add_little"), for: .normal)
        }
        if animator2 != nil {
            animator2.stop()
            musicCoverImageView.transform = .identity
            musicCoverImageView.layer.removeAllAnimations()
        }
    }
    
    var animator1: ChainableAnimator!
    var animator2: ChainableAnimator!
    
    @IBAction func addFollowTap(_ sender: UIButton) {
        print("点击关注")
        animator1 = ChainableAnimator(view:sender)
        
        UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve) {
            sender.setImage(UIImage(named: "iconSignDone"), for: .normal)
        } completion: { (_) in
            self.animator1.rotate(angle: 360)
                .thenAfter(t: 0.6)
                .wait(t: 0.3)
                .transform(scale: 0)
                .animate(t: 0.2)
        }
        
        
        

    }
    var aweme: AwemeList! {
        didSet {
            labelAuthor.text = aweme.author?.nickname
            labelDesc.text = aweme.desc
            let cover = aweme.video?.cover?.urlList![0]
//            print("image url", cover ?? "异常")
            
            // 设置视频封面图
            let coverUrl = URL(string: cover!)
            coverImageView.kf.setImage(with: coverUrl)
            
            // 设置音乐标题和作者
            labelMusic.text = (aweme.music?.title!)! + "-" + (aweme.music?.author!)!
            labelMusic.restartLabel()
            
            
            // 作者头像按钮
            let authorAvatar = aweme.author?.avatarThumb?.urlList![0]
            let authorAvatarUrl = URL(string: authorAvatar!)
            followBtn.kf.setImage(with: authorAvatarUrl, for: .normal)
//            followBtn.layer.cornerRadius = 25
//            followBtn.clipsToBounds = true
            
            // 点赞、评论、转发
            labelLikeNum.text = aweme.statistics?.diggCount?.towanStr
            labelcommentNum.text = aweme.statistics?.commentCount?.towanStr
            labelShareNum.text = aweme.statistics?.shareCount?.towanStr
            
            
            // 唱盘音乐封面
            let musicCover = aweme.music?.coverThumb?.urlList![0]
            musicCoverImageView.kf.setImage(with: URL(string: musicCover!))
            
            animator2 = ChainableAnimator(view: musicCoverImageView)
            animator2.rotate(angle: 180).animateWithRepeat(t: 3.5, count: 50)
        }
    }
    
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var pauseImageView: UIImageView!
    
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    @IBOutlet weak var labelMusic: MarqueeLabel!
    
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var addFollowBtn: UIButton!
    
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var labelLikeNum: UILabel!
    
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var labelcommentNum: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var labelShareNum: UILabel!
    
    
    @IBOutlet weak var diskView: UIView!
    @IBOutlet weak var subDiskView: UIView!
    @IBOutlet weak var musicCoverImageView: UIImageView!
    @IBOutlet weak var rotateDiskImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
