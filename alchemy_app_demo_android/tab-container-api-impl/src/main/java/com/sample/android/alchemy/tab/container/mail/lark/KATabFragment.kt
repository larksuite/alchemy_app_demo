package com.sample.android.alchemy.tab.container.mail.lark

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.sample.android.alchemy.tab.container.R
import com.sample.android.alchemy.tab.container.mail.MainFragment

class KATabFragment : Fragment() {
    companion object {
        private const val TAG = "KATabFragment"
    }

    private val mainFragment = MainFragment()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.alchemy_sample_ka_fragment_impl, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        childFragmentManager
            .beginTransaction().add(R.id.container, mainFragment, "main")
            .addToBackStack("main")
            .commit()
    }
}