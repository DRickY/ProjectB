//
//  SnapLayout.swift
//  ProjectB
//
//  Created by Dmytro on 2/28/24.
//

import UIKit

public class SnappingLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    
    var scale: CGFloat = 0.28
    
    // MARK: - UICollectionViewFlowLayout
    
    public override
    func prepare() {
        super.prepare()
        updateLayout()
    }

    public override
    func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                             withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                             withScrollingVelocity: velocity)
        }

        let midWidth = (collectionView.bounds.width * 0.5)
        let proposedContentOffsetCenterOrigin = proposedContentOffset.x + midWidth

        let target = CGRect(x: proposedContentOffset.x, y: 0,
                                width: collectionView.bounds.width, height: collectionView.bounds.height)
        
        let offsetAdjusment = snapEffect(targetRect: target, proposedContentOffset: proposedContentOffsetCenterOrigin)

        return CGPoint(x: floor(proposedContentOffset.x + offsetAdjusment), y: proposedContentOffset.y)
    }
    
    public override 
    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let parentAtts = super.layoutAttributesForElements(in: rect),
                let attributes = NSArray(array: parentAtts, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }

        return attributes.map { transformLayoutAttributes($0) }
    }
    
    public override 
    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    fileprivate func updateLayout() {
        guard let collectionView = self.collectionView else { return }
        let collectionSize = collectionView.bounds.size
        
        let yInset = (collectionSize.height - itemSize.height) / 2
        let xInset = (collectionSize.width - itemSize.width) / 2

        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
    }

    private final func transformLayoutAttributes(_ attribute: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attribute }
        
        let targetRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let distance = abs(targetRect.midX - attribute.center.x)
        let positiveDistance = abs(distance / itemSize.width)
        let scale = 1 + scale * (1 - positiveDistance)
        
        attribute.transform3D = CATransform3DMakeScale(scale, scale, 1)
        attribute.zIndex = Int(scale.rounded())
        
        return attribute
    }

    final private func snapEffect(targetRect: CGRect, proposedContentOffset: CGFloat) -> CGFloat {
        var offsetAdjusment = CGFloat.greatestFiniteMagnitude
        guard let layout = super.layoutAttributesForElements(in: targetRect) else { return offsetAdjusment }

        layout.forEach { layoutAttributes in
            let itemHorizontalPosition = layoutAttributes.center.x

            if abs(itemHorizontalPosition - proposedContentOffset) < abs(offsetAdjusment) {
                offsetAdjusment = itemHorizontalPosition - proposedContentOffset
            }
        }

        return offsetAdjusment
    }
}
