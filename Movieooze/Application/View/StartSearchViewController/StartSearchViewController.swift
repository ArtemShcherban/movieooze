//
//  StartSearchViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 29.11.2021.
//

import UIKit

class StartSearchViewController: UIViewController {
    static let reuseidentifier = String(describing: StartSearchViewController.self)


    @IBOutlet weak var tabsView: TabsView!
    
    var currentIndex: Int = 0
    var pageController: UIPageViewController!
    var searchNetworkViewModel: SearchNetworkViewModel!
    var startTab: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Result of search"
        startTab = searchNetworkViewModel.indexOfViewController()
        setupTabs()
        setupPageViewConroller()
    }

    // Change the color of Status Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }

    func setupTabs() {
        // Add Tabs (Set 'icon'to nil if you don't want to have icons)
        
        let tabTittle = { (arrayWithResults: [Any], tabName: String) in arrayWithResults.count > 0 ? "\(tabName) (\(arrayWithResults.count))" : tabName}
        tabsView.tabs = [
            Tab(icon: nil, title: tabTittle(searchNetworkViewModel.arrayOFMovies, "Movies")),
            Tab(icon: nil, title: tabTittle(searchNetworkViewModel.arrayOfTvShows, "Tv Shows")),
            Tab(icon: nil, title: tabTittle(searchNetworkViewModel.arrayOfPersons, "Persons"))
        ]
        
        // Set TabMode to '.fixed' for stretched tabs in full width of screen or '.scrollable' for scrolling to see all tabs
        tabsView.tabMode = .fixed
        
        // TabView Customization
        tabsView.titleColor = .white
        tabsView.iconColor = .white
        tabsView.indicatorColor = .orange
        tabsView.titleFont = UIFont.systemFont(ofSize: 16, weight: .thin)
        tabsView.tintColor = .white
        tabsView.collectionView.backgroundColor = Constants.MyColors.myDarkGreyColor
        
        tabsView.delegate = self
        
        // Set the selected Tab when the app starts
        tabsView.collectionView.selectItem(at: IndexPath(item: startTab, section: 0), animated: true, scrollPosition: .centeredVertically)
    }
    
    func setupPageViewConroller() {
        // PageViewController
        self.pageController = storyboard?.instantiateViewController(withIdentifier: "TabsPageViewController") as! TabsPageViewController
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        
        // Set PageViewController Delegate & DataSource
        pageController.delegate = self
        pageController.dataSource = self
        
        // Set the selected ViewController in the PageViewController when the app starts
        pageController.setViewControllers([showViewController(startTab)!], direction: .forward, animated: true, completion: nil)
        
        // PageViewController Constraints
        self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.pageController.view.topAnchor.constraint(equalTo: self.tabsView.bottomAnchor), self.pageController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), self.pageController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), self.pageController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        self.pageController.didMove(toParent: self)
    }
    
    func showViewController(_ index: Int) -> UIViewController? {
        if (self.tabsView.tabs.count == 0) || (index >= self.tabsView.tabs.count) {
            return nil
        }
        
       currentIndex = index
        if index == 0 {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: MovieSearchResultViewController.reuseidentifier) as! MovieSearchResultViewController
            contentVC.searchNetworkViewModel = searchNetworkViewModel
            contentVC.pageIndex = index
            return contentVC
            
        } else if index == 1 {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: TvShowSearchResultViewController.reuseidentifier) as! TvShowSearchResultViewController
            contentVC.searchNetworkViewModel = searchNetworkViewModel
        contentVC.pageIndex = index
        return contentVC
            
        } else if index == 2 {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: PersonSearchResultViewController.reuseidentifier) as! PersonSearchResultViewController
            contentVC.searchNetworkViewModel = searchNetworkViewModel
        contentVC.pageIndex = index
        return contentVC
            
        } else {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: MovieSearchResultViewController.reuseidentifier) as! MovieSearchResultViewController
            contentVC.pageIndex = index
            return contentVC
        }
    }
}

extension StartSearchViewController: TabsDelegate {
   
    func tabsViewDidSelectItemAt(position: Int) {
        // Check if the selected tab cell position is the same with the current position in pageController, if not, then go forward or backward
        if position != currentIndex {
            if position > currentIndex {
                self.pageController.setViewControllers([showViewController(position)!], direction: .forward, animated: true, completion: nil)
            } else {
                self.pageController.setViewControllers([showViewController(position)!], direction: .reverse, animated: true, completion: nil)
            }
            tabsView.collectionView.scrollToItem(at: IndexPath(item: position, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension StartSearchViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
   
    // return ViewController when go forward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        // Don't do anything when viewpager reach the number of tabs
        if index == tabsView.tabs.count {
            return nil
        } else {
            index += 1
            return self.showViewController(index)
        }
    }
    // return ViewController when go backward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = pageViewController.viewControllers?.first
        var index: Int
        index = getVCPageIndex(vc)
        
        if index == 0 {
            return nil
        } else {
            index -= 1
            return self.showViewController(index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if completed {
                guard let vc = pageViewController.viewControllers?.first else { return  }
               
                let index: Int
                
                index = getVCPageIndex(vc)
                
                tabsView.collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredVertically)
                // Animate the tab in the TabsView to be centered when you are scrolling using .scrollable
                tabsView.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    // Return the current position that is saved in the UIViewControllers we have in the UIPageViewController
    func getVCPageIndex(_ viewController: UIViewController?) -> Int {
        switch viewController {
        case is MovieSearchResultViewController:
            let vc = viewController as! MovieSearchResultViewController
            return vc.pageIndex
        case is TVShowsViewConroller:
            let vc = viewController as! TVShowsViewConroller
            return vc.pageIndex
        case is Demo2ViewConroller:
            let vc = viewController as! Demo2ViewConroller
            return vc.pageIndex
        default:
            let vc = viewController as! MoviesViewController
            return vc.pageIndex
        }
    }
}
